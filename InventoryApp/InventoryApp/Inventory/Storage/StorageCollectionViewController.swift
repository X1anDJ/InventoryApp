//
//  StorageCollectionViewController.swift
//  InventoryApp
//
//  Created by Dajun Xian on 2024/1/13.
//

import UIKit
class StorageCollectionViewController: UICollectionViewController {
    
    var viewModel: SectionViewModel!
    
    
    init(viewModel: SectionViewModel!) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(collectionViewLayout: layout)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(StorageCollectionViewCell.self, forCellWithReuseIdentifier: "StorageCell")
        self.collectionView.register(ShowMoreCollectionViewCell.self, forCellWithReuseIdentifier: "ShowMoreCell")
        configureLayout()
        self.collectionView.showsHorizontalScrollIndicator = false
    }

    private func configureLayout() {
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        let spacing: CGFloat = 10
        let itemsPerRow: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 6 : 3
        let totalSpacing = spacing * (itemsPerRow + 1)
        let cellWidth = (UIScreen.main.bounds.width - totalSpacing) / itemsPerRow
        let cellHeight = cellWidth + 30 // Adjust as needed

        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10)
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let productCount = viewModel.getNumberOfProducts()
        return productCount > 8 ? 9 : productCount + 1
    }


    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let productCount = viewModel.getNumberOfProducts()
        
        // Check if this is the "Show More" cell
        if (productCount > 8 && indexPath.row == 8) || (productCount <= 8 && indexPath.row == productCount) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShowMoreCell", for: indexPath) as! ShowMoreCollectionViewCell
            // Configure the "Show More" cell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StorageCell", for: indexPath) as! StorageCollectionViewCell
            if let product = viewModel.getProduct(at: indexPath.row) {
                let cardViewModel = CardViewModel(product: product)
                cell.cardViewModel = cardViewModel
                cell.updateProductCardViewController()
            }
            return cell
        }
    }

    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productCount = viewModel.getNumberOfProducts()
        
        if (productCount > 8 && indexPath.row == 8) || (productCount <= 8 && indexPath.row == productCount) {
            // Handle "Show More" cell selection
        }
    }



    
}
