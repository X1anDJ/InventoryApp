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
    let containerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize product data and fetch
        let product = Product()
        cardViewModel = CardViewModel(product: product)
        cardViewModel.fetchProductData()
        
        // Initialize and configure child view controllers
        frontCardViewController = FrontCardViewController(viewModel: cardViewModel)
        backCardViewController = BackCardViewController(viewModel: cardViewModel)
        
        setupChildViewController(frontCardViewController, in: self.view)
        setupChildViewController(backCardViewController, in: self.view)
        backCardViewController.view.isHidden = true

        // Bind ViewModel updates to UI updates
        cardViewModel.onProductUpdated = { [weak self] updatedProduct in
            self?.updateUI(with: updatedProduct)
        }
        
        setupContainer()

        // Add Front and Back Card View Controllers to the Container View
        setupChildViewController(frontCardViewController, in: containerView)
        setupChildViewController(backCardViewController, in: containerView)
        backCardViewController.view.isHidden = true


        // Add tap gesture recognizer to toggle between views
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(flipCard))
        view.addGestureRecognizer(tapGesture)
    }
    
    func setupContainer() {
        
        // Setup the shadow container view
        containerView.frame = self.view.bounds
        containerView.layer.cornerRadius = 10
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        containerView.layer.shadowRadius = 4
        containerView.layer.shadowOpacity = 0.1
        containerView.clipsToBounds = false
        self.view.addSubview(containerView)
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        // Set the frame for frontCardViewController
        frontCardViewController.view.frame = self.view.bounds
        frontCardViewController.view.layer.cornerRadius = 10
        frontCardViewController.view.clipsToBounds = true
        
        // Set the frame for backCardViewController
        // Set a smaller frame for backCardViewController to create a floating effect
        let scale: CGFloat = 0.99
        let smallerFrame = self.view.bounds.insetBy(dx: containerView.bounds.width * (1 - scale) / 2,
                                                        dy: containerView.bounds.height * (1 - scale) / 2)
        backCardViewController.view.frame = smallerFrame
        backCardViewController.view.layer.cornerRadius = 10
        backCardViewController.view.clipsToBounds = true
    }

    
    private func updateUI(with product: Product) {
        frontCardViewController.configure(with: cardViewModel)
        backCardViewController.configure(with: cardViewModel)
    }
    
    // containerView is self.view, which is deternmined by CollectionViewController
    // using """layout.itemSize = CGSize(width: cellWidth, height: cellWidth + 40)"""
    private func setupChildViewController(_ childController: UIViewController, in containerView: UIView) {
        addChild(childController)
        containerView.addSubview(childController.view)
        childController.didMove(toParent: self)

        // Assuming the containerView is the view of ProductCardViewController
        childController.view.frame = containerView.bounds
    }

    
    @objc private func flipCard() {
        let isFrontCardVisible = frontCardViewController.view.isHidden

        // Set the new shadow offset based on which card will be visible after the flip
        let newShadowOffset: CGSize = isFrontCardVisible ? CGSize(width: 0, height: 0) : CGSize(width: 5, height: 10)
        
        let transitionOptions: UIView.AnimationOptions = isFrontCardVisible ? [.transitionFlipFromLeft, .showHideTransitionViews] : [.transitionFlipFromRight, .showHideTransitionViews]
//        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]

        UIView.transition(with: self.view, duration: 0.2, options: transitionOptions, animations: {
            // Flip the visibility of the front and back card views
            self.frontCardViewController.view.isHidden = !self.frontCardViewController.view.isHidden
            self.backCardViewController.view.isHidden = !self.backCardViewController.view.isHidden

            // Update the shadow offset here
            self.containerView.layer.shadowOffset = newShadowOffset

        }, completion: { finished in
            // This block can be used for any additional actions after the animation is complete
        })

        print("frontCardViewController.view.isHidden ? \(frontCardViewController.view.isHidden)")
    }

}
