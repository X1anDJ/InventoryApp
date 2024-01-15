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
    
    init(productID: String = "", productName: String = "", productPicture: String = "default_image", quantity: Int = 0, remainingDay: Int = 0) {
        self.productID = productID
        self.productName = productName
        self.productPicture = productPicture
        self.quantity = quantity
        self.remainingDay = remainingDay
    }
    
}
