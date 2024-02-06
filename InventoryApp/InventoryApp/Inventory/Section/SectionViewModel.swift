//
//  SectionViewModel.swift
//  InventoryApp
//
//  Created by Dajun Xian on 2024/1/19.
//

class SectionViewModel {
    ///Mark:
    ///section: initialize by mapping each section of userViewModel
    ///sectionRepository: use current section or id to pass in the repository to manage the local data.
    private var section: Section
    private var sectionRepository: SectionRepository = SectionRepository()
    var sortingRule: SortingRule {
        return section.sortingRule
    }
    
    init(section: Section) {
        self.section = section
        //self.sectionRepository = sectionRepository
        print("Initializing SectionViewModel with \(section.products.count) products. Title: \(section.title), Sorting Rule: \(section.sortingRule.description)")
        fetchUpdatedSection()
    }

    // GET:
    
    func getSectionTitle() -> String {
        return section.title
    }
    
    func getSectionRule() -> Int {
        return section.rule
    }
    
    // Get the number of products in the section
    func getNumberOfProducts() -> Int {
        return section.products.count
    }

    // Get a specific product by index
    func getProduct(at index: Int) -> Product? {
        guard index >= 0 && index < section.products.count else {
            print("Index out of range or no product at index: \(index)")
            return nil
        }
        //print("Get product called")
        return section.products[index]
    }


    
    // SET:
    
    // Add a product to the section
    func addProduct(_ product: Product) {
        section.products.append(product)
        updateSection()
    }
    

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
    
    
    // Sort
    func sortProducts(rule: SortingRule) {
        print("Sorting products with rule: \(rule.description)")
        sectionRepository.setSectionSortingRule(sectionId: section.id, rule: rule)
        fetchUpdatedSection()
    }
    
    private func fetchUpdatedSection() {
        if let updatedSection = sectionRepository.fetchSectionById(section.id) {
            print("Updated section fetched successfully. Old title: \(self.section.title), New title: \(updatedSection.title)")
            self.section = updatedSection
        } else {
            print("Failed to fetch updated section for sectionId: \(section.id)")
        }
    }
}
