//
//  SectionViewModel.swift
//  InventoryApp
//
//  Created by Dajun Xian on 2024/1/19.
//

class SectionViewModel {
    private var section: Section
    private var sectionRepository: SectionRepository

    init(section: Section, sectionRepository: SectionRepository = SectionRepository()) {
        self.section = section
        self.sectionRepository = sectionRepository
    }

    // GET:
    
    // Get the number of products in the section
    func getNumberOfProducts() -> Int {
        return section.products.count
    }

    // Get a specific product by index
    func getProduct(at index: Int) -> Product? {
        guard index >= 0 && index < section.products.count else {
            return nil
        }
        return section.products[index]
    }

    // Add a product to the section
    func addProduct(_ product: Product) {
        section.products.append(product)
        updateSection()
    }
    
    
    // SET:

    // Update a product in the section
    func updateProduct(at index: Int, with product: Product) {
        guard index >= 0 && index < section.products.count else {
            return
        }
        section.products[index] = product
        updateSection()
    }

    func updateSection() {
        sectionRepository.updateSection(section)
    }
}
