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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewElements()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViewElements()
    }
    
    private func setupViewElements() {
        // Setup the subviews here
        addSubview(productImageView)
        addSubview(daysCircleLabel)
        addSubview(quantityCircleLabel)
        addSubview(productNameLabel)
        
        // Customize the UI elements
        productImageView.contentMode = .scaleAspectFit
        
        daysCircleLabel.textAlignment = .center
        daysCircleLabel.backgroundColor = .green
        daysCircleLabel.layer.cornerRadius = 20
        daysCircleLabel.clipsToBounds = true
        
        quantityCircleLabel.textAlignment = .center
        quantityCircleLabel.backgroundColor = .blue
        quantityCircleLabel.layer.cornerRadius = 20
        quantityCircleLabel.clipsToBounds = true
        
        productNameLabel.numberOfLines = 2
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Define margins
        let margin: CGFloat = 10
        let labelHeight: CGFloat = 40
        let labelWidth: CGFloat = 40
        
        productImageView.frame = CGRect(x: margin, y: margin, width: bounds.width - 2 * margin, height: bounds.height - labelHeight - 3 * margin)
        
        daysCircleLabel.frame = CGRect(x: bounds.width - labelWidth - margin, y: productImageView.frame.maxY + margin, width: labelWidth, height: labelHeight)
        
        quantityCircleLabel.frame = CGRect(x: bounds.width - labelWidth - margin, y: daysCircleLabel.frame.maxY + margin, width: labelWidth, height: labelHeight)
        
        productNameLabel.frame = CGRect(x: margin, y: productImageView.frame.maxY + margin, width: bounds.width - 2 * (labelWidth + margin), height: labelHeight)
    }
    
    func configure(with viewModel: CardViewModel) {
        // Configure the view with data from the view model
        productImageView.image = UIImage(named: viewModel.productImageName)

        daysCircleLabel.text = viewModel.remainingDays
        quantityCircleLabel.text = viewModel.quantity
        productNameLabel.text = viewModel.productName
        
        print("Viewmodel: \(viewModel.productImageName)")
    }
}
