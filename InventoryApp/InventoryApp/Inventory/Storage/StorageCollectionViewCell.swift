//
//  StorageCollectionViewCell.swift
//  InventoryApp
//
//  Created by Dajun Xian on 2024/1/13.
//
import UIKit

class StorageCollectionViewCell: UICollectionViewCell {
    var productCardViewController: ProductCardViewController!
    var cardViewModel: CardViewModel? {
        didSet {
            updateProductCardViewController()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateProductCardViewController() {
        // Remove existing ProductCardViewController if it exists
        productCardViewController?.willMove(toParent: nil)
        productCardViewController?.view.removeFromSuperview()
        productCardViewController?.removeFromParent()
        productCardViewController = nil

        // Initialize and add the new ProductCardViewController
        if let cardViewModel = cardViewModel {
            let newVC = ProductCardViewController(cardViewModel: cardViewModel)
            contentView.addSubview(newVC.view)
            newVC.view.frame = contentView.bounds
            productCardViewController = newVC
        }
    }
//    
//    private func setupProductCardViewController() {
//        // Initialize ProductCardViewController and add it as a child view controller
//        productCardViewController = ProductCardViewController(cardViewModel: cardViewModel)
//        contentView.addSubview(productCardViewController.view)
//        productCardViewController.view.frame = contentView.frame
//    }
    
    private func configure(with viewModel: CardViewModel) {
        self.cardViewModel = viewModel
    }

    // Helper function to find parent view controller
    private func parentViewController() -> UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder?.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        productCardViewController?.willMove(toParent: nil)
        productCardViewController?.view.removeFromSuperview()
        productCardViewController?.removeFromParent()
        productCardViewController = nil
    }
}
