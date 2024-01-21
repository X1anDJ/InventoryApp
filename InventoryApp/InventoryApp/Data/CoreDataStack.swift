//
//  CoreDataStack.swift
//  InventoryApp
//
//  Created by Dajun Xian on 2024/1/18.
//

import CoreData

class CoreDataStack {
    static let shared = CoreDataStack()
    
    
    //Let the container to be AppDataModel
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "AppDataModel")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    // context for fetching, creating, and saving entities
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // save
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
