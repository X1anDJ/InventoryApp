//
//  BackCardView.swift
//  InventoryApp
//
//  Created by Dajun Xian on 2024/1/12.
//

import Foundation
import UIKit

class BackCardView: UIView {
    
    let daysCircleLabel = UILabel()
    let quantityCircleLabel = UILabel()
    
    let decreaseDaysButton = UIButton()
    let increaseDaysButton = UIButton()
    let decreaseQuantityButton = UIButton()
    let increaseQuantityButton = UIButton()
    
    var daysValue: Int = 0 {
        didSet { daysCircleLabel.text = "\(daysValue)d" }
    }
    
    var quantityValue: Int = 0 {
        didSet { quantityCircleLabel.text = "x\(quantityValue)" }
    }
    
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
        
        // Set up UI elements here
        setupCircleLabel(daysCircleLabel, backgroundColor: .systemGreen)
        setupCircleLabel(quantityCircleLabel, backgroundColor: .systemCyan)
        setupButton(decreaseDaysButton, title: "-")
        setupButton(increaseDaysButton, title: "+")
        setupButton(decreaseQuantityButton, title: "-")
        setupButton(increaseQuantityButton, title: "+")
        
        // Add UI elements as subviews
        addSubviews(daysCircleLabel, decreaseDaysButton, increaseDaysButton,
                    quantityCircleLabel, decreaseQuantityButton, increaseQuantityButton)
    }
    
    private func setupCircleLabel(_ label: UILabel, backgroundColor: UIColor) {
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = backgroundColor
        label.layer.cornerRadius = 17.5
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupButton(_ button: UIButton, title: String) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.systemGray, for: .normal)
        button.backgroundColor = UIColor.systemBackground
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray4.cgColor
        
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Layout your subviews here
        // ...
    }
    
    private func setupConstraints() {
            // Constants for layout
            let circleDiameter: CGFloat = 35
            let buttonSize: CGFloat = 30
            let changeNumberButtonConstant: CGFloat = 5
        
            NSLayoutConstraint.activate([
                // Days Circle Label Constraints
                daysCircleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                daysCircleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
                daysCircleLabel.widthAnchor.constraint(equalToConstant: circleDiameter),
                daysCircleLabel.heightAnchor.constraint(equalToConstant: circleDiameter),
                
                // Increase Days Button Constraints
                increaseDaysButton.centerYAnchor.constraint(equalTo: daysCircleLabel.centerYAnchor),
                increaseDaysButton.leadingAnchor.constraint(equalTo: daysCircleLabel.trailingAnchor, constant: changeNumberButtonConstant),
                increaseDaysButton.widthAnchor.constraint(equalToConstant: buttonSize),
                increaseDaysButton.heightAnchor.constraint(equalToConstant: buttonSize),
                
                // Decrease Days Button Constraints
                decreaseDaysButton.centerYAnchor.constraint(equalTo: daysCircleLabel.centerYAnchor),
                decreaseDaysButton.trailingAnchor.constraint(equalTo: daysCircleLabel.leadingAnchor, constant: -changeNumberButtonConstant),
                decreaseDaysButton.widthAnchor.constraint(equalToConstant: buttonSize),
                decreaseDaysButton.heightAnchor.constraint(equalToConstant: buttonSize),
                
                // Quantity Circle Label Constraints
                quantityCircleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                quantityCircleLabel.topAnchor.constraint(equalTo: daysCircleLabel.bottomAnchor, constant: 20),
                quantityCircleLabel.widthAnchor.constraint(equalToConstant: circleDiameter),
                quantityCircleLabel.heightAnchor.constraint(equalToConstant: circleDiameter),
                
                // Increase Quantity Button Constraints
                increaseQuantityButton.centerYAnchor.constraint(equalTo: quantityCircleLabel.centerYAnchor),
                increaseQuantityButton.leadingAnchor.constraint(equalTo: quantityCircleLabel.trailingAnchor, constant: changeNumberButtonConstant),
                increaseQuantityButton.widthAnchor.constraint(equalToConstant: buttonSize),
                increaseQuantityButton.heightAnchor.constraint(equalToConstant: buttonSize),
                
                // Decrease Quantity Button Constraints
                decreaseQuantityButton.centerYAnchor.constraint(equalTo: quantityCircleLabel.centerYAnchor),
                decreaseQuantityButton.trailingAnchor.constraint(equalTo: quantityCircleLabel.leadingAnchor, constant: -changeNumberButtonConstant),
                decreaseQuantityButton.widthAnchor.constraint(equalToConstant: buttonSize),
                decreaseQuantityButton.heightAnchor.constraint(equalToConstant: buttonSize)
            ])
        }

}
