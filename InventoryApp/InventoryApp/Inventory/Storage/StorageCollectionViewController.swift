//
//  StorageCollectionViewController.swift
//  InventoryApp
//
//  Created by Dajun Xian on 2024/1/13.
//

import UIKit
class StorageCollectionViewController: UICollectionViewController {
    
    var viewModel: SectionViewModel!
    
    private var itemsPerRow: CGFloat {
        // Check if the device is an iPad
        if UIDevice.current.userInterfaceIdiom == .pad {
            return 6 // For iPad
        } else {
            return 3 // For iPhone
        }
    }
    
    init(viewModel: SectionViewModel!) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(StorageCollectionViewCell.self, forCellWithReuseIdentifier: "cell")

        // Set layout
        setupLayout()
    }

    private func setupLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10

        let totalSpacing = spacing * (itemsPerRow + 1) // Spacing on both sides
        let cellWidth = (UIScreen.main.bounds.width - totalSpacing) / itemsPerRow
        
        
 
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth + 30)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        
        // Add spacing around the edges of the collection view
        let edgeSpacing: CGFloat = 10 // Adjust this value as needed for edge spacing
        layout.sectionInset = UIEdgeInsets(top: edgeSpacing, left: edgeSpacing, bottom: edgeSpacing, right: 0)

        collectionView.collectionViewLayout = layout

    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getNumberOfProducts()
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! StorageCollectionViewCell

        if let product = viewModel.getProduct(at: indexPath.row) {
            let cardViewModel = CardViewModel(product: product)
            cell.cardViewModel = cardViewModel
        }

        return cell
    }
}
