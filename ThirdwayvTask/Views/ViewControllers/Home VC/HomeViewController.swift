//
//  ViewController.swift
//  ThirdwayvTask
//
//  Created by Ahmed Soultan on 14/12/2022.
//

import UIKit
import CoreData
import Reachability

class HomeViewController: UIViewController {
    
    // MARK: - OUTLETS
    @IBOutlet weak var productsCollectionView: UICollectionView!
    
    // MARK: - VARIABLES
    let homeVM = HomeViewModel()
    var products: [Product]?
    let userDefaults = UserDefaults.standard
    let reachability = try! Reachability()
    
    let layout = homeLayout()
    
    // MARK: - LIFE-CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initVC()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
            do{
              try reachability.startNotifier()
            }catch{
              print("could not start reachability notifier")
            }
    }
    
    deinit {
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: nil)
    }
}

// MARK: - SETUP
extension HomeViewController {
    private func initVC() {
        layout.delegate = self
        layout.numberOfColumns = 2
        productsCollectionView.collectionViewLayout = layout
        
        setupVM()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
        productsCollectionView.register(HomeCollectionCell.nib, forCellWithReuseIdentifier: HomeCollectionCell.identifier)
    }
    // END OF EXTENSION
}

// MARK: - METHODS
extension HomeViewController {
    @objc func reachabilityChanged(note: Notification) {
      let reachability = note.object as! Reachability
      switch reachability.connection {
      case .wifi:
          homeVM.getData()
      case .cellular:
          homeVM.getData()
      case .unavailable:
          self.products = HomeViewController.getAllObjects
          productsCollectionView.reloadData()
      case .none:
          print("none")
      }
    }
        // END OF EXTENSION
}

// MARK: - VIEWMODEL
extension HomeViewController {
    func setupVM() {
        homeVM.bindModelOnSuccess = { [weak self] in
            self?.onSuccess()
        }
        homeVM.bindErrorOnFailure = { [weak self] in
            self?.onFailure()
        }
        homeVM.bindNewData = { [weak self] in
            self?.addNewData()
        }
    }
    
    func onSuccess() {
        guard let products = homeVM.model else {return}
        self.products = products
        HomeViewController.saveAllObjects(allObjects: products)
        DispatchQueue.main.async {
            self.productsCollectionView.reloadData()
        }
    }
    
    func addNewData() {
        guard let newProducts = homeVM.newData else {return}
        self.products?.append(contentsOf: newProducts)
        DispatchQueue.main.async {
            self.productsCollectionView.reloadData()
        }
    }
    
    func onFailure() {
        print("Failed to load data")
    }
    // END OF EXTENSION
}

// MARK: - COLLECTION VIEW
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, HomeLayoutDelegate {
    
    func collectionView(collectionView: UICollectionView, heightForItemAtIndexPath indexPath: IndexPath) -> CGFloat {
        
        return CGFloat(self.products?[indexPath.item].image?.height ?? 0) + CGFloat(self.products?[indexPath.item].productDescription?.count ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.products?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let productCell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionCell.identifier, for: indexPath) as! HomeCollectionCell
        productCell.setupCell(imageUrl: products?[indexPath.item].image?.url ?? "",
                              productName: (products?[indexPath.item].price?.description ?? "0") + " $",
                              productDesc: products?[indexPath.item].productDescription ?? "")
        return productCell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == (products?.count ?? 0) / 2 {
            layout.cache.removeAll()
            homeVM.requestNewData()
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsVC = DetailsVC()
        detailsVC.productData = products?[indexPath.item]
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
}

// MARK: - USER-DEFAULTS
extension HomeViewController {
    static var getAllObjects: [Product] {
          let defaultObject = Product(id: 1,
                                      productDescription: "",
                                      image: Image(width: 0, height: 0, url: ""),
                                      price: 0)
          if let objects = UserDefaults.standard.value(forKey: "SavedProducts") as? Data {
             let decoder = JSONDecoder()
             if let objectsDecoded = try? decoder.decode(Array.self, from: objects) as [Product] {
                return objectsDecoded
             } else {
                return [defaultObject]
             }
          } else {
             return [defaultObject]
          }
       }

     static func saveAllObjects(allObjects: [Product]) {
          let encoder = JSONEncoder()
          if let encoded = try? encoder.encode(allObjects){
             UserDefaults.standard.set(encoded, forKey: "SavedProducts")
          }
     }
}
