//
//  CDSection+CoreDataProperties.swift
//  
//
//  Created by Dajun Xian on 2024/1/15.
//
//

import Foundation
import CoreData


extension CDSection {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDSection> {
        return NSFetchRequest<CDSection>(entityName: "CDSection")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var rule: Int16
    @NSManaged public var title: String?
    @NSManaged public var products: NSSet?
    @NSManaged public var user: CDUser?

}

// MARK: Generated accessors for products
extension CDSection {

    @objc(addProductsObject:)
    @NSManaged public func addToProducts(_ value: CDProduct)

    @objc(removeProductsObject:)
    @NSManaged public func removeFromProducts(_ value: CDProduct)

    @objc(addProducts:)
    @NSManaged public func addToProducts(_ values: NSSet)

    @objc(removeProducts:)
    @NSManaged public func removeFromProducts(_ values: NSSet)

}
