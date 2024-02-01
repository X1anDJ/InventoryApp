//
//  ShowMoreCollectionViewCell.swift
//  InventoryApp
//
//  Created by Dajun Xian on 2024/1/30.
//
import UIKit

class ShowMoreCollectionViewCell: UICollectionViewCell {

    private let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false // Enable Auto Layout
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "chevron.right.circle.fill") // SF Symbol
        imageView.tintColor = .systemGray2
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupStyle()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        contentView.addSubview(arrowImageView)

        NSLayoutConstraint.activate([
            arrowImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            arrowImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            arrowImageView.widthAnchor.constraint(equalToConstant: 35), // Set as needed
            arrowImageView.heightAnchor.constraint(equalToConstant: 35)  // Set as needed
        ])
    }
    
    private func setupStyle() {
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 10
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 0)
        contentView.layer.shadowRadius = 4
        contentView.layer.shadowOpacity = 0.1
        contentView.clipsToBounds = false
    }
}
