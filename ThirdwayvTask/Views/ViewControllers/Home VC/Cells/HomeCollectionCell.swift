//
//  HomeCollectionCell.swift
//  ThirdwayvTask
//
//  Created by Ahmed Soultan on 15/12/2022.
//

import UIKit

class HomeCollectionCell: UICollectionViewCell {
    
    // MARK: - OUTLETS
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productDesc: UILabel!
    
    // MARK: - VARIABLES
    static let identifier = "HomeCollectionCell"
    static let nib = UINib(nibName: identifier, bundle: .main)
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell(imageUrl: String, productName: String, productDesc: String) {
        self.productImage.setImageByKingFisher(url: imageUrl)
        self.productName.text = productName
        self.productDesc.text = productDesc
    }
}
