//
//  Section.swift
//  InventoryApp
//
//  Created by Dajun Xian on 2024/1/15.
//

import Foundation

class Section {
    var id: UUID
    var title: String
    var rule: Int
    var products: [Product]

    init(id: UUID, name: String, rule: Int, products: [Product]) {
        self.id = id
        self.title = name
        self.rule = rule
        self.products = products
    }
    
}
