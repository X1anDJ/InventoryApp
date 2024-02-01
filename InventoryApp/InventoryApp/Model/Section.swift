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
    var rule: Int           //How many days left
    var sortingRule: SortingRule
    var products: [Product]

    init(id: UUID, name: String, rule: Int, sortingRule: SortingRule, products: [Product]) {
        self.id = id
        self.title = name
        self.rule = rule
        self.sortingRule = sortingRule
        self.products = products
    }
    
}
