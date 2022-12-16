//
//  Product.swift
//  ThirdwayvTask
//
//  Created by Ahmed Soultan on 14/12/2022.
//

import Foundation

// MARK: - Product
struct Product : Codable {
    let id : Int?
    let productDescription : String?
    let image : Image?
    let price : Int?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case productDescription = "productDescription"
        case image = "image"
        case price = "price"
    }
}

// MARK: - Image
struct Image : Codable {
    let width : Int?
    let height : Int?
    let url : String?

    enum CodingKeys: String, CodingKey {
        case width = "width"
        case height = "height"
        case url = "url"
    }
}
