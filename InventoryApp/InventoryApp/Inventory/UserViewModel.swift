//
//  UserViewModel.swift
//  InventoryApp
//
//  Created by Dajun Xian on 2024/1/19.
//
import Foundation

class UserViewModel {
    let userRepository: UserRepository
    let sectionRepository: SectionRepository
    var user: CDUser?
    var sections: [Section] = []
    
    // Properties for the view
    var userName: String {
        return user?.name ?? "Unknown"
    }

    // Initialization
    init(userRepository: UserRepository = UserRepository(),
         sectionRepository: SectionRepository = SectionRepository()) {
        self.userRepository = userRepository
        self.sectionRepository = sectionRepository
    }

    // Fetch User
    func fetchUser(completion: @escaping (Bool) -> Void) {
        if let fetchedUser = userRepository.fetchUser() {
            self.user = fetchedUser
            completion(true)
        } else {
            completion(false)
        }
    }

    func fetchUserAndSections(completion: @escaping (Bool) -> Void) {
        guard let fetchedUser = userRepository.fetchUser() else {
            completion(false)
            return
        }

        self.user = fetchedUser
        let userId = fetchedUser.id ?? UUID()  // Provide a default UUID if `id` is nil
        print("User name: \(self.user?.name ?? "No user name")")
        self.sections = sectionRepository.fetchSections(for: userId)
        print("UserViewModel [section] count = \(sections.count)")
        for section in sections {
            print("Section \(section.title) has sorting rule: \(section.sortingRule.description)")
        }
        completion(true)
    }

    // Update User
    func updateUser(name: String, completion: (Bool) -> Void) {
        guard let user = self.user else {
            completion(false)
            return
        }

        userRepository.updateUser(user, name: name)
        completion(true)
    }

}
