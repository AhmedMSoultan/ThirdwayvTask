//
//  HomeViewModel.swift
//  ThirdwayvTask
//
//  Created by Ahmed Soultan on 14/12/2022.
//

import Foundation

class HomeViewModel {
    
    var networkLayer: NetworkLayer = .shared
   
    var bindErrorOnFailure: ()->() = {}
    var bindModelOnSuccess: ()->() = {}
    var bindNewData: ()->() = {}
    
    var errorMessage: String? {
        didSet {
            bindErrorOnFailure()
        }
    }
    
    var model: [Product]? {
        didSet {
            bindModelOnSuccess()
        }
    }
    
    var newData: [Product]? {
        didSet {
            bindNewData()
        }
    }
    
    func getData() {
        networkLayer.get(endPoint: .home, className: [Product].self) { products in
            if products.count != 0 {
                self.model = products
            } else {
                self.errorMessage = "There is no data"
            }
        }
    }
    
    func requestNewData() {
        networkLayer.get(endPoint: .home, className: [Product].self) { products in
            if products.count != 0 {
                self.newData = products
            } else {
                self.errorMessage = "There is no data"
            }
        }
    }
}
