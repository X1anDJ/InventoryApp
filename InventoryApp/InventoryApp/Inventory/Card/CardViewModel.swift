//
//  CardViewModel.swift
//  InventoryApp
//
//  Created by Dajun Xian on 2024/1/12.
//


import UIKit

class CardViewModel {
    private var product: Product {
        didSet {
            onProductUpdated?(product)
        }
    }
    
    var productName: String {
        product.productName
    }
    
    var productImageName: String {
        product.productPicture
    }
    
    var remainingDays: String {
        "\(product.remainingDay)d"
    }
    
    var quantity: String {
        "x\(product.quantity)"
    }
    
    var remainingDaysInNumber: Int {
        product.remainingDay
    }

    var quantityInNumber: Int {
        product.quantity
    }

    
    var onProductUpdated: ((Product) -> Void)?
    
    init(product: Product) {
        self.product = product
    }
    
    init() {
        let mockProduct = Product(productID: "12345", productName: "香蕉", productPicture: "新鲜香蕉", quantity: 10, remainingDay: 5)
        self.product = mockProduct
    }
    
    func updateProduct(remainingDay: Int, quantity: Int) {
        product.remainingDay = remainingDay
        product.quantity = quantity
        onProductUpdated?(product)
    }
    
    func fetchProductData() {
        // Simulate a network delay
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.1) { [weak self] in
            // Simulate fetched product data
            let mockProduct = Product(productID: "12345", productName: "恩佐法拉利牌新鲜非洲香蕉", productPicture: "新鲜香蕉", quantity: 99, remainingDay: 9)

            // Update the product on the main thread
            DispatchQueue.main.async {
                self?.product = mockProduct
                self?.onProductUpdated?(mockProduct)
            }
        }
    }
    
    func getProduct() -> Product {
        return product
    }
    
    func decreaseDays() {
        product.remainingDay -= 1
        onProductUpdated?(product)
    }
    func increaseDays() {
        product.remainingDay += 1
        onProductUpdated?(product)
    }
    func decreaseQuantity() {
        product.quantity -= 1
        onProductUpdated?(product)
    }
    func increaseQuantity() {
        product.quantity -= 1
        onProductUpdated?(product)
    }
    

    func updateRemainingDays(_ days: Int) {
        product.remainingDay = days
        // Notify observers about the update
        onProductUpdated?(product)
    }

    func updateQuantity(_ quantity: Int) {
        product.quantity = quantity
        // Notify observers about the update
        onProductUpdated?(product)
    }

}
