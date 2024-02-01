//
//  CustomHorizontalLayout.swift
//  InventoryApp
//
//  Created by Dajun Xian on 2024/1/31.
//

import Foundation
import UIKit
class CustomHorizontalLayout: UICollectionViewLayout {
    private var cache = [UICollectionViewLayoutAttributes]()
    private var contentWidth: CGFloat = 0

    private var numberOfColumns: Int {
        // Define how many columns you want in each 'row'
        return 2
    }

    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: collectionView?.bounds.height ?? 0)
    }

    override func prepare() {
        guard let collectionView = collectionView else { return }
        cache.removeAll()

        let columnWidth = collectionView.bounds.width / CGFloat(numberOfColumns)
        var xOffset = [CGFloat]()
        for column in 0..<numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        var column = 0
        var yOffset: CGFloat = 0

        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            let height: CGFloat = columnWidth + 30 // Modify this as needed
            let frame = CGRect(x: xOffset[column], y: yOffset, width: columnWidth, height: height)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = frame
            cache.append(attributes)

            yOffset += height
            if column >= numberOfColumns - 1 {
                yOffset = 0
                column = 0
                contentWidth += columnWidth
            } else {
                column += 1
            }
        }
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cache.filter { attributes in
            rect.intersects(attributes.frame)
        }
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache.first { attributes in
            attributes.indexPath == indexPath
        }
    }
}
