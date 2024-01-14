//
//  FrontCardView.swift
//  InventoryApp
//
//  Created by Dajun Xian on 2024/1/12.
//

import UIKit

class FrontCardView: UIView {
    
    let productImageView = UIImageView()
    let daysCircleLabel = UILabel()
    let quantityCircleLabel = UILabel()
    let productNameLabel = UILabel()
    let separatorView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewElements()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViewElements()
        setupConstraints()
    }
    
    private func setupViewElements() {
        backgroundColor = .systemBackground
        
        addSubview(productImageView)
        addSubview(daysCircleLabel)
        addSubview(quantityCircleLabel)
        addSubview(productNameLabel)
        addSubview(separatorView)
        
        // Configure the product image view
        productImageView.contentMode = .scaleAspectFit
        //productImageView.clipsToBounds = true
        
        // Configure the days circle label
        daysCircleLabel.textAlignment = .center
        daysCircleLabel.backgroundColor = .systemGreen
        daysCircleLabel.textColor = .white
        daysCircleLabel.clipsToBounds = true
        
        // Configure the quantity circle label
        quantityCircleLabel.textAlignment = .center
        quantityCircleLabel.backgroundColor = .systemCyan
        quantityCircleLabel.textColor = .white
        quantityCircleLabel.clipsToBounds = true
        
        // Configure the product name label
        productNameLabel.numberOfLines = 0
        productNameLabel.backgroundColor = .tertiarySystemBackground
        productNameLabel.textAlignment = .center
        
        // Configure the separator view
        separatorView.backgroundColor = .systemGray5
    }
    
//    private func setupView() {
//        // Set background color
//        backgroundColor = .gray
//
//        // Set corner radius
//        layer.cornerRadius = 10
//
//        // Optional: Add border
//        layer.borderWidth = 1.0
//        layer.borderColor = UIColor.systemGray5.cgColor
//        layer.shadowColor = UIColor.systemRed.cgColor
//        layer.shadowRadius = 3.0
//        layer.shadowOffset = CGSize(width: 0, height: 2)
//        // ... (other setup code)
//    }
//    
    
    private func setupConstraints() {
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        daysCircleLabel.translatesAutoresizingMaskIntoConstraints = false
        quantityCircleLabel.translatesAutoresizingMaskIntoConstraints = false
        productNameLabel.translatesAutoresizingMaskIntoConstraints = false
        separatorView.translatesAutoresizingMaskIntoConstraints = false

        
        // Constants for layout
        let circleDiameter: CGFloat = 35
        let separatorHeight: CGFloat = 1
        let labelHeight: CGFloat = 40
        let overlap: CGFloat = circleDiameter / 2
        
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: topAnchor),
            productImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            productImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            // widthAnchor is the parent view's width, determined by by CollectionViewController
            // using """layout.itemSize = CGSize(width: cellWidth, height: cellWidth + 40)"""
            productImageView.widthAnchor.constraint(equalTo: widthAnchor),
            productImageView.heightAnchor.constraint(equalTo: productImageView.widthAnchor),

            separatorView.topAnchor.constraint(equalTo: productImageView.bottomAnchor),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: separatorHeight),
            
            productNameLabel.topAnchor.constraint(equalTo: separatorView.bottomAnchor),
            productNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            productNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            productNameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: labelHeight),
            
            daysCircleLabel.topAnchor.constraint(equalTo: productImageView.topAnchor),
            daysCircleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            daysCircleLabel.widthAnchor.constraint(equalToConstant: circleDiameter),
            daysCircleLabel.heightAnchor.constraint(equalToConstant: circleDiameter),
            
            quantityCircleLabel.topAnchor.constraint(equalTo: daysCircleLabel.bottomAnchor, constant: 10),
            quantityCircleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            quantityCircleLabel.widthAnchor.constraint(equalToConstant: circleDiameter),
            quantityCircleLabel.heightAnchor.constraint(equalToConstant: circleDiameter),
        ])
        
        daysCircleLabel.layer.cornerRadius = circleDiameter / 2
        daysCircleLabel.layer.masksToBounds = true
        quantityCircleLabel.layer.cornerRadius = circleDiameter / 2
        quantityCircleLabel.layer.masksToBounds = true
    }
    
    func configure(with viewModel: CardViewModel) {
        // Configure the view with data from the view model
        productImageView.image = UIImage(named: viewModel.productImageName)
        daysCircleLabel.text = viewModel.remainingDays
        quantityCircleLabel.text = viewModel.quantity
        productNameLabel.text = viewModel.productName
    }
}
