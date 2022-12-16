//
//  DetailsVC.swift
//  ThirdwayvTask
//
//  Created by Ahmed Soultan on 15/12/2022.
//

import UIKit

class DetailsVC: UIViewController {
    
    // MARK: - OUTLETS
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productDesc: UILabel!
    
    var productData: Product?
    
    // MARK: - LIFE-CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC(imageUrl: productData?.image?.url ?? "",
                price: (productData?.price?.description ?? "") + " $",
                Desc: productData?.productDescription ?? "")
    }
    
    func setupVC(imageUrl: String, price: String, Desc: String) {
        productImage.setImageByKingFisher(url: imageUrl)
        productPrice.text = price
        productDesc.text = Desc
    }
}
