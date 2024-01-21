//
//  UserViewModel.swift
//  InventoryApp
//
//  Created by Dajun Xian on 2024/1/19.
//
import Foundation

class UserViewModel {
    private let userRepository: UserRepository
    private let sectionRepository: SectionRepository
    private var user: CDUser?
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

    // Fetch User and Sections
    func fetchUserAndSections(completion: @escaping (Bool) -> Void) {
        let fetchedUser = userRepository.fetchUser()
        
        self.user = fetchedUser
        //self.sections = sectionRepository.fetchSections(for: fetchedUser?)
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
