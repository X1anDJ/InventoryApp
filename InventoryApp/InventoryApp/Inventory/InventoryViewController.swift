//
//  InventoryViewController.swift
//  InventoryApp
//
//  Created by Dajun Xian on 2024/1/7.
//
import Foundation
import UIKit

class InventoryViewController: UIViewController, UIScrollViewDelegate {
    let scrollView = UIScrollView()
    let inventoryStackView = UIStackView()
    let inventoryLabel = UILabel()
    var sectionViewControllers: [SectionViewController] = [] // Array of SectionViewController instances

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self

        // Create SectionViewControllers and add them to the array
        for _ in 0...2 {
            let sectionViewController = SectionViewController()
            sectionViewControllers.append(sectionViewController)
        }
        
        style() // Setup styles for the UI elements
        layout() // Layout the UI elements
        addSectionViewControllers() // Add SectionViewControllers to the stack view
        
        if let barBackgroundView = navigationController?.navigationBar.subviews.first(where: { String(describing: type(of: $0)) == "_UIBarBackground" }) {
            if let backgroundImageView = barBackgroundView.subviews.first(where: { $0 is UIImageView }) as? UIImageView {
                // Now you have a reference to the UIImageView
                // Apply your custom modifications here, for example:
                backgroundImageView.alpha = 0.5 // Set to 50% transparency
            }
        }
        
        
    }
    
    

    func style() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        inventoryStackView.translatesAutoresizingMaskIntoConstraints = false
        inventoryStackView.axis = .vertical
        inventoryStackView.spacing = 0

        inventoryLabel.translatesAutoresizingMaskIntoConstraints = false
        inventoryLabel.text = "我的库存"
        // Change to use system font with semi-bold weight
        inventoryLabel.font = UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .largeTitle).pointSize, weight: .semibold)
    }

    
    func layout() {
        view.addSubview(scrollView)

        // Constraints for UIScrollView
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        scrollView.addSubview(inventoryStackView)

        // Constraints for InventoryStackView inside UIScrollView
        NSLayoutConstraint.activate([
            inventoryStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            inventoryStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            inventoryStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            inventoryStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            inventoryStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])

        // Layout for the label inside a horizontal stack view
        let horizontalStackView = UIStackView()
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.axis = .horizontal

        let spacerView = UIView()
        spacerView.translatesAutoresizingMaskIntoConstraints = false
        spacerView.widthAnchor.constraint(equalToConstant: 10).isActive = true

        horizontalStackView.addArrangedSubview(spacerView)
        horizontalStackView.addArrangedSubview(inventoryLabel)

        inventoryStackView.addArrangedSubview(horizontalStackView)
    }

    func addSectionViewControllers() {
        for sectionViewController in sectionViewControllers {
            addChild(sectionViewController)
            inventoryStackView.addArrangedSubview(sectionViewController.view)
            sectionViewController.view.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                sectionViewController.view.leadingAnchor.constraint(equalTo: inventoryStackView.leadingAnchor),
                sectionViewController.view.trailingAnchor.constraint(equalTo: inventoryStackView.trailingAnchor),
                sectionViewController.view.heightAnchor.constraint(equalToConstant: 430)
                // Height constraint is not set, assuming the content sizes itself
            ])

            sectionViewController.didMove(toParent: self)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let offset = scrollView.contentOffset.y
            if offset > 50 { // Trigger point for showing the navigation bar
                showNavigationBar(true)
            } else {
                showNavigationBar(false)
            }
        }

    private func showNavigationBar(_ show: Bool) {
        guard let navigationBar = navigationController?.navigationBar else { return }

        UIView.animate(withDuration: 0.3, animations: {
            navigationBar.alpha = show ? 1.0 : 0.0
        }) { _ in
            navigationBar.isHidden = !show
            if show {
                navigationBar.isTranslucent = false
                navigationBar.barTintColor = UIColor.systemBackground  // Replace with your desired color
                self.navigationItem.title = "我的库存" // Set the title when the bar is shown
            }
        }
    }

}
