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
    private var sectionRepository: SectionRepository

    init(section: Section, sectionRepository: SectionRepository = SectionRepository()) {
        self.section = section
        self.sectionRepository = sectionRepository
        print("Initializing SectionViewModel with \(section.products.count) products.")
        //print("using sorting rule: \(rule)")
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
        print("Get product called")
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
        sectionRepository.sortSection(sectionId: section.id, rule: rule)
        fetchUpdatedSection()
    }
    
    private func fetchUpdatedSection() {
        if let updatedSection = sectionRepository.fetchSectionById(section.id) {
            self.section = updatedSection
        }
    }
}
