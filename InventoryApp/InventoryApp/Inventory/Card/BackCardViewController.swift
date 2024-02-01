//
//  BackCardViewController.swift
//  InventoryApp
//
//  Created by Dajun Xian on 2024/1/12.
//
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
    
    override func loadView() {
        backCardView = BackCardView()
        view = backCardView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure(with: viewModel)
        // Set up a listener for ViewModel updates
        viewModel.onProductUpdated = { [weak self] _ in
            DispatchQueue.main.async {
                self?.configure(with: self?.viewModel ?? CardViewModel(product: Product()))
            }
        }
        
        // Assign actions to buttons
        backCardView.decreaseDaysButton.addTarget(self, action: #selector(decreaseDays), for: .touchUpInside)
        backCardView.increaseDaysButton.addTarget(self, action: #selector(increaseDays), for: .touchUpInside)
        backCardView.decreaseQuantityButton.addTarget(self, action: #selector(decreaseQuantity), for: .touchUpInside)
        backCardView.increaseQuantityButton.addTarget(self, action: #selector(increaseQuantity), for: .touchUpInside)
    }
    
    @objc private func decreaseDays() {
        viewModel.decreaseDays()
    }

    @objc private func increaseDays() {
        viewModel.increaseDays()
    }

    @objc private func decreaseQuantity() {
        viewModel.decreaseQuantity()
    }

    @objc private func increaseQuantity() {
        viewModel.increaseQuantity()
    }

    
    func configure(with viewModel: CardViewModel) {
        backCardView?.configure(with: viewModel)
    }
}
