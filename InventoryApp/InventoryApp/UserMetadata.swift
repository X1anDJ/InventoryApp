//
//  UserMetadata.swift
//  InventoryApp
//
//  Created by Dajun Xian on 2024/1/20.
//

import Foundation

class UserMetadata {
    var userViewModel = UserViewModel()
    
    init() {
        let section1 = createOneSection1()
        let section2 = createOneSection2()
        let section3 = createOneSection3()
        
        
        let user = userViewModel.userRepository.createUser(id: UUID(), name: "Dajun Xian")
        print("Welcome, \(String(describing: user.name))")
        userViewModel.sectionRepository.createSection(for: user.id!, with: section1)
        userViewModel.sectionRepository.createSection(for: user.id!, with: section2)
        userViewModel.sectionRepository.createSection(for: user.id!, with: section3)
    }
    
    func createOneSection1() -> Section {
        let section1 = Section(id: UUID(), name: "保鲜区", rule: 30, products: [Product(id: UUID(), title: "香蕉", picture: "新鲜香蕉", quantity: 13, remainingDays: 10), Product(id: UUID(), title: "新鲜香蕉", picture: "新鲜香蕉", quantity: 13, remainingDays: 10)])
        return section1
    }
    
    func createOneSection2() -> Section {
        let section1 = Section(id: UUID(), name: "冷冻区", rule: 180, products: [Product(id: UUID(), title: "香蕉", picture: "新鲜香蕉", quantity: 13, remainingDays: 10), Product(id: UUID(), title: "新鲜香蕉", picture: "新鲜香蕉", quantity: 13, remainingDays: 10)])
        return section1
    }
    
    func createOneSection3() -> Section {
        let section1 = Section(id: UUID(), name: "常温区", rule: 30, products: [Product(id: UUID(), title: "香蕉", picture: "新鲜香蕉", quantity: 13, remainingDays: 10), Product(id: UUID(), title: "新鲜香蕉", picture: "新鲜香蕉", quantity: 13, remainingDays: 10)])
        return section1
    }
}
