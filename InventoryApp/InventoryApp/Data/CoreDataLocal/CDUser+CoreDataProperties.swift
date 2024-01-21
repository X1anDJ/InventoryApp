//
//  CDUser+CoreDataProperties.swift
//  
//
//  Created by Dajun Xian on 2024/1/15.
//
//

import Foundation
import CoreData


extension CDUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDUser> {
        return NSFetchRequest<CDUser>(entityName: "CDUser")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var sections: NSSet?

}

// MARK: Generated accessors for sections
extension CDUser {

    @objc(addSectionsObject:)
    @NSManaged public func addToSections(_ value: CDSection)

    @objc(removeSectionsObject:)
    @NSManaged public func removeFromSections(_ value: CDSection)

    @objc(addSections:)
    @NSManaged public func addToSections(_ values: NSSet)

    @objc(removeSections:)
    @NSManaged public func removeFromSections(_ values: NSSet)

}
