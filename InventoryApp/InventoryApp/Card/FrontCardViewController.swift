//
//  FrontCardViewController.swift
//  InventoryApp
//
//  Created by Dajun Xian on 2024/1/12.
//
import UIKit

class FrontCardViewController: UIViewController {
    
    var frontCardView: FrontCardView!
    var viewModel: CardViewModel!
    
    
    init(viewModel: CardViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        // Instantiate and assign custom view as the view controller's view
        frontCardView = FrontCardView()
        view = frontCardView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up a listener for ViewModel updates
        viewModel.onProductUpdated = { [weak self] _ in
            DispatchQueue.main.async {
                self?.configure(with: self?.viewModel ?? CardViewModel(product: Product()))
            }
        }

        // Initial configuration
        configure(with: viewModel)
    }
    
    func configure(with viewModel: CardViewModel) {
        frontCardView?.configure(with: viewModel)
    }
}

