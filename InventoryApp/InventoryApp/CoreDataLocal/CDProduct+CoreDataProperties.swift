//
//  CDProduct+CoreDataProperties.swift
//  
//
//  Created by Dajun Xian on 2024/1/15.
//
//

import Foundation
import CoreData


extension CDProduct {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDProduct> {
        return NSFetchRequest<CDProduct>(entityName: "CDProduct")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var picture: String?
    @NSManaged public var quantity: Int16
    @NSManaged public var remainingDays: Int16
    @NSManaged public var title: String?
    @NSManaged public var section: CDSection?

}
