//
//  ProductRepository.swift
//  InventoryApp
//
//  Created by Dajun Xian on 2024/1/18.
//

import CoreData
import Foundation

class ProductRepository {
    let coreDataStack: CoreDataStack

    init(coreDataStack: CoreDataStack = .shared) {
        self.coreDataStack = coreDataStack
    }

    func createProduct(for sectionId: UUID, with product: Product) {
        guard let section = fetchCDSectionById(id: sectionId) else { return }

        let cdProduct = CDProduct(context: coreDataStack.context)
        cdProduct.id = product.id
        cdProduct.title = product.title
        cdProduct.picture = product.picture
        cdProduct.quantity = Int16(product.quantity)
        cdProduct.remainingDays = Int16(product.remainingDays)
        section.addToProducts(cdProduct)

        coreDataStack.saveContext()
    }

    func fetchProducts(for sectionId: UUID) -> [Product] {
        guard let section = fetchCDSectionById(id: sectionId) else { return [] }
        return section.products?.allObjects.compactMap { mapCDProductToProduct(cdProduct: $0 as? CDProduct) } ?? []
    }

    // Other CRUD operations...

    private func fetchCDSectionById(id: UUID) -> CDSection? {
        let request: NSFetchRequest<CDSection> = CDSection.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)

        do {
            let results = try coreDataStack.context.fetch(request)
            return results.first
        } catch {
            print("Error fetching CDSection by id: \(error)")
            return nil
        }
    }


    private func mapCDProductToProduct(cdProduct: CDProduct?) -> Product? {
        guard let cdProduct = cdProduct,
              let id = cdProduct.id,
              let title = cdProduct.title,
              let picture = cdProduct.picture else {
            return nil
        }
        let quantity = Int(cdProduct.quantity)
        let remainingDays = Int(cdProduct.remainingDays)
        return Product(id: id, title: title, picture: picture, quantity: quantity, remainingDays: remainingDays)
    }

}
