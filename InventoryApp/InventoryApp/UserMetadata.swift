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
        if userViewModel.userRepository.userExists() {
            print("User already exists.")
//            guard let user = userViewModel.userRepository.fetchUser() else {
//                return
//            }
        } else {
            let user = userViewModel.userRepository.createUser(id: UUID(), name: "Dajun Xian")
            let section1 = createOneSection1()
            let section2 = createOneSection2()
            userViewModel.sectionRepository.createSection(for: user.id!, with: section1)
            userViewModel.sectionRepository.createSection(for: user.id!, with: section2)
            
            print("Creating new user: \(String(describing: user.name))")
        }

        //userViewModel.sectionRepository.createSection(for: user.id!, with: section3)
    }
    
    
    func createOneSection1() -> Section {
        let products = [
            Product(id: UUID(), title: "鸡蛋", picture: "鸡蛋", quantity: 1, remainingDays: 11),
            Product(id: UUID(), title: "USDA Choice  有机西冷牛排", picture: "USDA Choice  有机西冷牛排", quantity: 1, remainingDays: 10),
            Product(id: UUID(), title: "好时巧克力", picture: "好时巧克力", quantity: 2, remainingDays: 9),
            Product(id: UUID(), title: "新鲜香蕉", picture: "新鲜香蕉", quantity: 3, remainingDays: 8),
            Product(id: UUID(), title: "鸡蛋", picture: "鸡蛋", quantity: 4, remainingDays: 7),
            Product(id: UUID(), title: "USDA Choice  有机西冷牛排", picture: "USDA Choice  有机西冷牛排", quantity: 13, remainingDays: 6),
            Product(id: UUID(), title: "好时巧克力", picture: "好时巧克力", quantity: 5, remainingDays: 5),
            Product(id: UUID(), title: "新鲜香蕉", picture: "新鲜香蕉", quantity: 6, remainingDays: 4),
            Product(id: UUID(), title: "新鲜香蕉", picture: "新鲜香蕉", quantity: 7, remainingDays: 3),
            Product(id: UUID(), title: "鸡蛋", picture: "鸡蛋", quantity: 8, remainingDays: 2),
            Product(id: UUID(), title: "USDA Choice  有机西冷牛排", picture: "USDA Choice  有机西冷牛排", quantity: 9, remainingDays:1),
        
        ]
        let sortingRule = SortingRule.quantityHighToLow
        let section = Section(id: UUID(), name: "保鲜区", rule: 30, sortingRule: sortingRule, products: products)
        return section
    }
    
    func createOneSection2() -> Section {
        let products = [
            Product(id: UUID(), title: "鸡蛋", picture: "鸡蛋", quantity: 1 , remainingDays: 11),
            Product(id: UUID(), title: "USDA Choice  有机西冷牛排", picture: "USDA Choice  有机西冷牛排", quantity: 2, remainingDays: 10),
            Product(id: UUID(), title: "墨西哥面卷", picture: "墨西哥面卷", quantity: 3, remainingDays: 9),
            Product(id: UUID(), title: "Healthy Choice速冻菠菜番茄拌面", picture: "Healthy Choice速冻菠菜番茄拌面", quantity: 13, remainingDays: 8),
            Product(id: UUID(), title: "墨西哥面卷", picture: "墨西哥面卷", quantity: 4, remainingDays: 7),
            Product(id: UUID(), title: "鸡蛋", picture: "鸡蛋", quantity: 5, remainingDays: 6),
            Product(id: UUID(), title: "USDA Choice  有机西冷牛排", picture: "USDA Choice  有机西冷牛排", quantity: 6, remainingDays: 5),
            Product(id: UUID(), title: "墨西哥面卷", picture: "墨西哥面卷", quantity: 7, remainingDays: 5),
            Product(id: UUID(), title: "Healthy Choice速冻菠菜番茄拌面", picture: "Healthy Choice速冻菠菜番茄拌面", quantity: 8, remainingDays: 4),
            Product(id: UUID(), title: "墨西哥面卷", picture: "墨西哥面卷", quantity: 9, remainingDays: 3),
            Product(id: UUID(), title: "鸡蛋", picture: "鸡蛋", quantity: 10, remainingDays: 3),
            Product(id: UUID(), title: "USDA Choice  有机西冷牛排", picture: "USDA Choice  有机西冷牛排", quantity: 13, remainingDays: 2),
            Product(id: UUID(), title: "墨西哥面卷", picture: "墨西哥面卷", quantity: 11, remainingDays: 2),
            Product(id: UUID(), title: "Healthy Choice速冻菠菜番茄拌面", picture: "Healthy Choice速冻菠菜番茄拌面", quantity: 13, remainingDays: 10),
            Product(id: UUID(), title: "墨西哥面卷", picture: "墨西哥面卷", quantity: 12, remainingDays: 1),
        ]
        let sortingRule = SortingRule.newestToOldest
        let section = Section(id: UUID(), name: "冷冻区", rule: 180, sortingRule: sortingRule, products: products)
        return section
    }
//    
//    func createOneSection3() -> Section {
//        let products = [
//            Product(id: UUID(), title: "新鲜香蕉", picture: "新鲜香蕉", quantity: 13, remainingDays: 10),
//            Product(id: UUID(), title: "新鲜香蕉", picture: "新鲜香蕉", quantity: 4, remainingDays: 5),
//            Product(id: UUID(), title: "好时巧克力", picture: "好时巧克力", quantity: 2, remainingDays: 10),
//            Product(id: UUID(), title: "新鲜香蕉", picture: "新鲜香蕉", quantity: 13, remainingDays: 10),
//            Product(id: UUID(), title: "新鲜香蕉", picture: "新鲜香蕉", quantity: 13, remainingDays: 10),
//            Product(id: UUID(), title: "新鲜香蕉", picture: "新鲜香蕉", quantity: 4, remainingDays: 5),
//            Product(id: UUID(), title: "好时巧克力", picture: "好时巧克力", quantity: 2, remainingDays: 10),
//            Product(id: UUID(), title: "新鲜香蕉", picture: "新鲜香蕉", quantity: 13, remainingDays: 10),
//            Product(id: UUID(), title: "新鲜香蕉", picture: "新鲜香蕉", quantity: 13, remainingDays: 10),
//            Product(id: UUID(), title: "新鲜香蕉", picture: "新鲜香蕉", quantity: 4, remainingDays: 5),
//            Product(id: UUID(), title: "好时巧克力", picture: "好时巧克力", quantity: 2, remainingDays: 10),
//            Product(id: UUID(), title: "新鲜香蕉", picture: "新鲜香蕉", quantity: 13, remainingDays: 10)
//        
//        ]
//        let sortingRule = SortingRule.oldestToNewest
//        let section = Section(id: UUID(), name: "常温区", rule: 35, sortingRule: sortingRule, products: products)
//        return section
//    }
}
