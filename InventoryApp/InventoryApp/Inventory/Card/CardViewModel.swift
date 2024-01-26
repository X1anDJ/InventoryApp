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
            productRepository.updateProduct(product)
            onProductUpdated?(product)
        }
    }
    let productRepository: ProductRepository
    
    var productName: String {
        product.title
    }
    
    var productImageName: String {
        product.picture
    }
    
    var remainingDays: String {
        "\(product.remainingDays)d"
    }
    
    var quantity: String {
        "x\(product.quantity)"
    }
    
    var remainingDaysInNumber: Int {
        product.remainingDays
    }

    var quantityInNumber: Int {
        product.quantity
    }

    
    var onProductUpdated: ((Product) -> Void)?
    
    init(product: Product, productRepository: ProductRepository = ProductRepository()) {
        self.product = product
        self.productRepository = productRepository
    }
    
    func updateProduct(remainingDay: Int, quantity: Int) {
        product.remainingDays = remainingDay
        product.quantity = quantity
        onProductUpdated?(product)
    }
    
    func getProduct() -> Product {
        return product
    }
    
    func decreaseDays() {
        product.remainingDays -= 1
        onProductUpdated?(product)
    }
    func increaseDays() {
        product.remainingDays += 1
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
        product.remainingDays = days
        // Notify observers about the update
        onProductUpdated?(product)
    }

    func updateQuantity(_ quantity: Int) {
        product.quantity = quantity
        // Notify observers about the update
        onProductUpdated?(product)
    }

}
