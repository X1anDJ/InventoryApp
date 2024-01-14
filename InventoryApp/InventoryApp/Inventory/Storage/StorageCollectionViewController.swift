//
//  StorageCollectionViewController.swift
//  InventoryApp
//
//  Created by Dajun Xian on 2024/1/13.
//

import UIKit
class StorageCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(StorageCollectionViewCell.self, forCellWithReuseIdentifier: "cell")

        // Set layout
        setupLayout()
    }

    private func setupLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        let totalSpacing = spacing * 4 // Spacing on both sides
        let cellWidth = (UIScreen.main.bounds.width - totalSpacing) / 3
        
 
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth + 40) 
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        
        // Add spacing around the edges of the collection view
        let edgeSpacing: CGFloat = 10 // Adjust this value as needed for edge spacing
        layout.sectionInset = UIEdgeInsets(top: edgeSpacing, left: edgeSpacing, bottom: edgeSpacing, right: edgeSpacing)

        collectionView.collectionViewLayout = layout

    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5 // Temporary test
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! StorageCollectionViewCell
        // Configure your cell
        return cell
    }
}
