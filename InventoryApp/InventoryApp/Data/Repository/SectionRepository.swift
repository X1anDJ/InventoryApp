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
        let products = mapCDProductsToProducts(cdProducts: cdSection.products)
        return Section(id: id, name: title, rule: rule, products: products)
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

        coreDataStack.saveContext()
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
