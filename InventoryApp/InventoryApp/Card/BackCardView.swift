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
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViewElements()
    }
    
    private func setupViewElements() {
        // Set up UI elements here
        setupCircleLabel(daysCircleLabel, backgroundColor: .green)
        setupCircleLabel(quantityCircleLabel, backgroundColor: .blue)
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
        label.backgroundColor = backgroundColor
        label.layer.cornerRadius = 20
        label.clipsToBounds = true
    }
    
    private func setupButton(_ button: UIButton, title: String) {
        button.setTitle(title, for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
    }
    
    private func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Layout your subviews here
        // ...
    }
}
