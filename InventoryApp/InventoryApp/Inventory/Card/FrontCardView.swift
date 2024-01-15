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
    let productDescriptionStack = UIStackView()
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
        addSubview(productDescriptionStack)
        //addSubview(quantityCircleLabel)
        //addSubview(productNameLabel)
        addSubview(separatorView)
        
        
        // Configure the product image view
        productImageView.contentMode = .scaleAspectFit
        //productImageView.clipsToBounds = true
        
        // Configure the days circle label
        daysCircleLabel.textAlignment = .center
        daysCircleLabel.backgroundColor = .systemGreen
        daysCircleLabel.textColor = .white
        daysCircleLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        daysCircleLabel.clipsToBounds = true
        
        // Configure the quantity circle label
        quantityCircleLabel.textAlignment = .center
        quantityCircleLabel.backgroundColor = .tertiarySystemBackground
        quantityCircleLabel.font = UIFont.preferredFont(forTextStyle: .body)
        quantityCircleLabel.clipsToBounds = true

        
        // Configure the product name label
        productNameLabel.numberOfLines = 2
        productNameLabel.backgroundColor = .tertiarySystemBackground
        productNameLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        productNameLabel.textAlignment = .center
        
        // Configure the separator view
        separatorView.backgroundColor = .systemGray5
        
        // configure the product description stack
        productDescriptionStack.translatesAutoresizingMaskIntoConstraints = false
        productDescriptionStack.axis = .horizontal
        productDescriptionStack.spacing = 0
        
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
        //quantityCircleLabel.translatesAutoresizingMaskIntoConstraints = false
       // productNameLabel.translatesAutoresizingMaskIntoConstraints = false
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        productDescriptionStack.translatesAutoresizingMaskIntoConstraints = false
        productDescriptionStack.addArrangedSubview(productNameLabel)
        productDescriptionStack.addArrangedSubview(quantityCircleLabel)
        
        // Constants for layout
        let circleDiameter: CGFloat = 30
//        let distanceBetweenCircles: CGFloat = 6
//        let labelHeight: CGFloat = 30
//        let productDescriptionStackHeight: CGFloat = 5
        let separatorHeight: CGFloat = 1


        //let overlap: CGFloat = circleDiameter / 2
        
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: topAnchor),
            productImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            productImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            // widthAnchor is the parent view's width, determined by by CollectionViewController
            // using """layout.itemSize = CGSize(width: cellWidth, height: cellWidth + 40)"""
            productImageView.widthAnchor.constraint(equalTo: widthAnchor),
            productImageView.heightAnchor.constraint(equalTo: widthAnchor),

            separatorView.topAnchor.constraint(equalTo: productImageView.bottomAnchor),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: separatorHeight),
            
            productDescriptionStack.topAnchor.constraint(equalTo: separatorView.bottomAnchor),
            productDescriptionStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            productDescriptionStack.trailingAnchor.constraint(equalTo: trailingAnchor),
//            productDescriptionStack.heightAnchor.constraint(equalToConstant: productDescriptionStackHeight),
            productDescriptionStack.bottomAnchor.constraint(equalTo: bottomAnchor),
        
            
//            productNameLabel.topAnchor.constraint(equalTo: separatorView.bottomAnchor),
//            productNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
//            productNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
//            productNameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: circleDiameter),
            
            daysCircleLabel.topAnchor.constraint(equalTo: productImageView.topAnchor),
            daysCircleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            daysCircleLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: circleDiameter),
            daysCircleLabel.heightAnchor.constraint(equalToConstant: circleDiameter),
            
//            quantityCircleLabel.topAnchor.constraint(equalTo: daysCircleLabel.bottomAnchor, constant: distanceBetweenCircles),
//            quantityCircleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            quantityCircleLabel.widthAnchor.constraint(equalToConstant: circleDiameter + 10),
//           quantityCircleLabel.heightAnchor.constraint(equalToConstant: circleDiameter),
        ])
        
        daysCircleLabel.layer.cornerRadius = circleDiameter / 2
        daysCircleLabel.layer.masksToBounds = true
//        quantityCircleLabel.layer.cornerRadius = circleDiameter / 2
//        quantityCircleLabel.layer.masksToBounds = true
    }
    
    func configure(with viewModel: CardViewModel) {
        // Configure the view with data from the view model
        productImageView.image = UIImage(named: viewModel.productImageName)
        daysCircleLabel.text = viewModel.remainingDays
        quantityCircleLabel.text = viewModel.quantity
        productNameLabel.text = viewModel.productName

        daysCircleLabel.backgroundColor = viewModel.remainingDaysInNumber > 6 ? .systemGreen : viewModel.remainingDaysInNumber > 0 ? .systemOrange : .systemRed
        
    }
}
