//
//  Product.swift
//  InventoryApp
//
//  Created by Dajun Xian on 2024/1/15.
//

import Foundation
class Product {
    var id: UUID
    var title: String
    var picture: String
    var quantity: Int
    var remainingDays: Int
    
    // Convenience initializer with default values
    convenience init() {
        self.init(id: UUID(), title: "Default", picture: "default_image", quantity: 0, remainingDays: 0)
    }

    init(id: UUID, title: String, picture: String, quantity: Int, remainingDays: Int) {
        self.id = id
        self.title = title
        self.picture = picture
        self.quantity = quantity
        self.remainingDays = remainingDays
    }
}
