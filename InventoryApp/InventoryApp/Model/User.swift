//
//  User.swift
//  InventoryApp
//
//  Created by Dajun Xian on 2024/1/15.
//

import Foundation

class User {
    var id: UUID = UUID()
    var name: String = "未命名"
    var sections: [Section] = []
}
