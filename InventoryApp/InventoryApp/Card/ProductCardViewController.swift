//
//  ProductCardViewController.swift
//  InventoryApp
//
//  Created by Dajun Xian on 2024/1/12.
//
import UIKit

class ProductCardViewController: UIViewController {
    
    var frontCardViewController: FrontCardViewController!
    var backCardViewController: BackCardViewController!
    var cardViewModel: CardViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let product = Product() // Initialize your product model
        cardViewModel = CardViewModel(product: product)
        // Fetch product data
        cardViewModel.fetchProductData()
        
        // Initialize and configure child view controllers
        frontCardViewController = FrontCardViewController(viewModel: cardViewModel)
        backCardViewController = BackCardViewController(viewModel: cardViewModel)
        
        setupChildViewController(frontCardViewController)
        setupChildViewController(backCardViewController)
        backCardViewController.view.isHidden = true

        // Bind ViewModel updates to UI updates
        cardViewModel.onProductUpdated = { [weak self] updatedProduct in
            self?.updateUI(with: updatedProduct)
        }
        


        // Add tap gesture recognizer to toggle between views
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(flipCard))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func updateUI(with product: Product) {
        frontCardViewController.configure(with: cardViewModel)
        backCardViewController.configure(with: cardViewModel)
    }
    
    private func setupChildViewController(_ childController: UIViewController) {
        addChild(childController)
        view.addSubview(childController.view)
        childController.didMove(toParent: self)
        // Set the frame or constraints for childController's view
        // ...
    }
    
//    private func updateProductModel() {
//        // Assuming BackCardViewController has a way to provide updated values
//        let updatedRemainingDay = backCardViewController.remainingDays
//        let updatedQuantity = backCardViewController.quantity
//
//        cardViewModel.updateProduct(remainingDay: updatedRemainingDay, quantity: updatedQuantity)
//    }
    
    @objc private func flipCard() {
        let fromView = frontCardViewController.view.isHidden ? frontCardViewController.view : backCardViewController.view
        let toView = frontCardViewController.view.isHidden ? backCardViewController.view : frontCardViewController.view
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]

        UIView.transition(with: self.view, duration: 1.0, options: transitionOptions, animations: {
            fromView?.isHidden = true
            toView?.isHidden = false
        }, completion: nil)
    }

}
