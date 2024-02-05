//
//  SectionRepository.swift
//  InventoryApp
//
//  Created by Dajun Xian on 2024/1/18.
//
import CoreData
import Foundation

class SectionRepository {
    let coreDataStack: CoreDataStack

    init(coreDataStack: CoreDataStack = .shared) {
        self.coreDataStack = coreDataStack
    }

    func createSection(for userId: UUID, with section: Section) {
        guard let user = fetchCDUserById(id: userId) else {
            print("fetchCDUserById(id: \(userId)) failed")
            return
        }

        let cdSection = CDSection(context: coreDataStack.context)
        cdSection.id = section.id
        cdSection.title = section.title
        cdSection.rule = Int16(section.rule)
        cdSection.sortingRule = section.sortingRule.rawValue // Set initial sorting rule
        
        // Map and add products to the CDSection
        mapProductsToCDProducts(products: section.products, section: cdSection)

        user.addToSections(cdSection)
        print("Section \(section.title) created for user: \(userId)")
        coreDataStack.saveContext()
    }

    func fetchSections(for userId: UUID) -> [Section] {
        guard let user = fetchCDUserById(id: userId) else { return [] }
        return user.sections?.allObjects.compactMap { mapCDSectionToSection(cdSection: $0 as? CDSection) } ?? []
    }

    // Other CRUD operations...
    

    private func fetchCDUserById(id: UUID) -> CDUser? {
        let request: NSFetchRequest<CDUser> = CDUser.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)

        do {
            let results = try coreDataStack.context.fetch(request)
            return results.first
        } catch {
            print("Error fetching CDUser by id: \(error)")
            return nil
        }
    }


    private func mapCDSectionToSection(cdSection: CDSection?) -> Section? {
        guard let cdSection = cdSection,
              let id = cdSection.id,
              let title = cdSection.title else {
            return nil
        }
        let rule = Int(cdSection.rule)
        let sortingRuleValue = Int(cdSection.sortingRule)
        guard let sortingRule = SortingRule(rawValue: Int16(sortingRuleValue)) else {
            return nil
        }

        let products = mapCDProductsToProducts(cdProducts: cdSection.products).sorted {
            switch sortingRule {
            case .newestToOldest:
                return $0.remainingDays > $1.remainingDays
            case .oldestToNewest:
                return $0.remainingDays < $1.remainingDays
            case .quantityLowToHigh:
                return $0.quantity < $1.quantity
            case .quantityHighToLow:
                return $0.quantity > $1.quantity
            }
        }
        
        return Section(id: id, name: title, rule: rule, sortingRule: sortingRule, products: products)
    }


    
    
    private func mapProductsToCDProducts(products: [Product], section: CDSection) {
        products.forEach { product in
            let cdProduct = CDProduct(context: coreDataStack.context)
            cdProduct.id = product.id
            cdProduct.title = product.title
            cdProduct.picture = product.picture
            cdProduct.quantity = Int16(product.quantity)
            cdProduct.remainingDays = Int16(product.remainingDays)
            section.addToProducts(cdProduct)
        }
    }

    
    func updateSection(_ section: Section) {
        guard let cdSection = fetchCDSectionById(id: section.id) else { return }

        cdSection.title = section.title
        cdSection.rule = Int16(section.rule)
        cdSection.sortingRule = section.sortingRule.rawValue

        coreDataStack.saveContext()
    }

    func fetchSectionById(_ id: UUID) -> Section? {
        guard let cdSection = fetchCDSectionById(id: id) else {
            return nil
        }
        return mapCDSectionToSection(cdSection: cdSection)
    }
    
    private func fetchCDSectionById(id: UUID) -> CDSection? {
        let request: NSFetchRequest<CDSection> = CDSection.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        do {
            return try coreDataStack.context.fetch(request).first
        } catch {
            print("Error fetching CDSection by id: \(error)")
            return nil
        }
    }
    
    private func mapCDProductsToProducts(cdProducts: NSSet?) -> [Product] {
        guard let cdProducts = cdProducts as? Set<CDProduct> else { return [] }
        return cdProducts.compactMap { cdProduct in
            let id = cdProduct.id ?? UUID()
            let name = cdProduct.title ?? "Unknown"
            let picture = cdProduct.picture ?? "default_image"
            let quantity = Int(cdProduct.quantity)
            let remainingDays = Int(cdProduct.remainingDays)

            return Product(id: id, title: name, picture: picture, quantity: quantity, remainingDays: remainingDays)
        }
    }

}

extension SectionRepository {

    func sortSection(sectionId: UUID, rule: SortingRule) {
        guard let cdSection = fetchCDSectionById(id: sectionId), let products = cdSection.products as? Set<CDProduct> else {
            return
        }

        // Update the sorting rule in Core Data
        cdSection.sortingRule = rule.rawValue

        let sortedProducts: [CDProduct] = {
            switch rule {
            case .newestToOldest:
                return products.sorted { $0.remainingDays > $1.remainingDays }
            case .oldestToNewest:
                return products.sorted { $0.remainingDays < $1.remainingDays }
            case .quantityLowToHigh:
                return products.sorted { $0.quantity < $1.quantity }
            case .quantityHighToLow:
                return products.sorted { $0.quantity > $1.quantity }
            }
        }()

        if let existingProducts = cdSection.products {
            cdSection.removeFromProducts(existingProducts)
        }
        sortedProducts.forEach { cdSection.addToProducts($0) }

        coreDataStack.saveContext()
    }
}

enum SortingRule: Int16 {
    case newestToOldest = 0
    case oldestToNewest = 1
    case quantityLowToHigh = 2
    case quantityHighToLow = 3
    
    var description: String {
        switch self {
        case .newestToOldest:
            return "Newest to Oldest"
        case .oldestToNewest:
            return "Oldest to Newest"
        case .quantityLowToHigh:
            return "Quantity Low to High"
        case .quantityHighToLow:
            return "Quantity High to Low"
        }
    }
}
