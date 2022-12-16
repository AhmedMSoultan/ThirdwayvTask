//
//  ProductEntity+CoreDataProperties.swift
//  
//
//  Created by Ahmed Soultan on 16/12/2022.
//
//

import Foundation
import CoreData


extension ProductEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductEntity> {
        return NSFetchRequest<ProductEntity>(entityName: "ProductEntity")
    }

    @NSManaged public var imageUrl: String?
    @NSManaged public var price: Int32
    @NSManaged public var desc: String?
    @NSManaged public var imageHeight: Int32
    @NSManaged public var imageWidth: Int32
    @NSManaged public var id: Int32

}
