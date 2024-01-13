//
//  StorageCollectionViewCell.swift
//  InventoryApp
//
//  Created by Dajun Xian on 2024/1/13.
//
import UIKit

class StorageCollectionViewCell: UICollectionViewCell {
    var productCardViewController: ProductCardViewController!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupProductCardViewController()


    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupProductCardViewController() {
        // Initialize ProductCardViewController and add it as a child view controller
        productCardViewController = ProductCardViewController()
        contentView.addSubview(productCardViewController.view)
        productCardViewController.view.frame = contentView.frame
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

    // Ensure to remove the child view controller during cell reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        productCardViewController.willMove(toParent: nil)
        productCardViewController.view.removeFromSuperview()
        productCardViewController.removeFromParent()
    }
}
