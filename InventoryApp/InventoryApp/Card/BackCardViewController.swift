//
//  BackCardViewController.swift
//  InventoryApp
//
//  Created by Dajun Xian on 2024/1/12.
//

import Foundation
import UIKit

class BackCardViewController: UIViewController {
    
    var backCardView: BackCardView!
    var viewModel: CardViewModel!
    
    // Initialize with a view model
    init(viewModel: CardViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var daysValue: Int = 0 {
        didSet { backCardView.daysValue = daysValue }
    }
    
    var quantityValue: Int = 0 {
        didSet { backCardView.quantityValue = quantityValue }
    }
    
    override func loadView() {
        backCardView = BackCardView()
        view = backCardView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Assign actions to buttons
        backCardView.decreaseDaysButton.addTarget(self, action: #selector(decreaseDays), for: .touchUpInside)
        backCardView.increaseDaysButton.addTarget(self, action: #selector(increaseDays), for: .touchUpInside)
        backCardView.decreaseQuantityButton.addTarget(self, action: #selector(decreaseQuantity), for: .touchUpInside)
        backCardView.increaseQuantityButton.addTarget(self, action: #selector(increaseQuantity), for: .touchUpInside)
    }
    
    @objc private func decreaseDays() {
        daysValue = max(0, daysValue - 1)
        viewModel.updateRemainingDays(daysValue)
    }

    @objc private func increaseDays() {
        daysValue += 1
        viewModel.updateRemainingDays(daysValue)
    }

    @objc private func decreaseQuantity() {
        quantityValue = max(0, quantityValue - 1)
        viewModel.updateQuantity(quantityValue)
    }

    @objc private func increaseQuantity() {
        quantityValue += 1
        viewModel.updateQuantity(quantityValue)
    }

    
    // Method to configure the view with current product values
    func configure(with viewModel:
                   CardViewModel) {
        daysValue = viewModel.remainingDaysInNumber 
        quantityValue = viewModel.quantityInNumber 
    }
}
