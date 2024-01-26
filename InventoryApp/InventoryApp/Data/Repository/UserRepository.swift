//
//  UserRepository.swift
//  InventoryApp
//
//  Created by Dajun Xian on 2024/1/18.
//

import CoreData
import Foundation

class UserRepository {
    let coreDataStack: CoreDataStack

    init(coreDataStack: CoreDataStack = .shared) {
        self.coreDataStack = coreDataStack
    }

    // Fetch the user
    func fetchUser() -> CDUser? {
        let request: NSFetchRequest<CDUser> = CDUser.fetchRequest()
        do {
            let users = try coreDataStack.context.fetch(request)
            if let user = users.first {
                // Return the existing user
                return user
            } else {
                print("No user founded. Creating new user")
                return createUser(id: UUID(), name: "Default Name")
            }
        } catch {
            // Handle the fetch error appropriately
            print("Error fetching user: \(error)")
            return nil
        }
    }

    // Create a new user
    func createUser(id: UUID, name: String) -> CDUser {
        removeAllUsers()
        let newUser = CDUser(context: coreDataStack.context)
        newUser.id = id
        newUser.name = name
        coreDataStack.saveContext()
        return newUser
    }

    // Update an existing user
    func updateUser(_ user: CDUser, name: String) {
        user.name = name
        coreDataStack.saveContext()
    }

    // Delete a user
    func deleteUser(_ user: CDUser) {
        coreDataStack.context.delete(user)
        coreDataStack.saveContext()
    }

    // Function to remove all users
    func removeAllUsers() {
        let request: NSFetchRequest<CDUser> = CDUser.fetchRequest()
        
        do {
            let users = try coreDataStack.context.fetch(request)
            for user in users {
                coreDataStack.context.delete(user)
            }
            coreDataStack.saveContext()
            print("All users have been removed.")
        } catch {
            print("Error fetching users for deletion: \(error)")
        }
    }

}
