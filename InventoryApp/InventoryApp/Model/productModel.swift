//
//  productModel.swift
//  InventoryApp
//
//  Created by Dajun Xian on 2024/1/12.
//

import Foundation

class Product {
    var productID: String
    var productName: String
    var productPicture: String
    var quantity: Int
    var remainingDay: Int
    
    init(productID: String = "000000", productName: String = "Default Product", productPicture: String = "default_image", quantity: Int = 0, remainingDay: Int = 0) {
        self.productID = productID
        self.productName = productName
        self.productPicture = productPicture
        self.quantity = quantity
        self.remainingDay = remainingDay
    }
    
    func minusDays(_ days: Int) {
        remainingDay = max(0, remainingDay - days)
    }
    
    func addDays(_ days: Int) {
        remainingDay += days
    }
    
    func minusQuantity(_ number: Int) {
        quantity = max(0, quantity - number)
    }
    
    func addQuantity(_ number: Int) {
        quantity += number
    }
}
