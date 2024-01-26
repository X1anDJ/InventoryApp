//
//  InventoryViewController.swift
//  InventoryApp
//
//  Created by Dajun Xian on 2024/1/7.
//
import Foundation
import UIKit

/*
 - InventoryViewController : has var sectionViewControllers: [SectionViewController] = []
    - ScrollView
        - inventoryStackView
            - sectionViewController.view
 
 */
class InventoryViewController: UIViewController, UIScrollViewDelegate {
    
    var userViewModel: UserViewModel!
    let scrollView = UIScrollView()
    let inventoryStackView = UIStackView()
    let inventoryLabel = UILabel()
    var sectionViewControllers: [SectionViewController] = [] // Array of SectionViewController instances
    
    init(userViewModel: UserViewModel!) {
        super.init(nibName: nil, bundle: nil)
        self.userViewModel = userViewModel
        
        print("InventoryViewController initialized")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        fetchUserDataAndSetupSections()
        style() // Setup styles for the UI elements
        layout() // Layout the UI elements

    }
    

    func fetchUserDataAndSetupSections() {
        userViewModel.fetchUserAndSections { [weak self] success in
            guard let self = self, success else {
                print("fetch failed")
                return
            }
            self.setupSectionViewControllers()
            print("userViewModel.fetchUserAndSections Successful")
        }
    }

    func setupSectionViewControllers() {
        
        sectionViewControllers = userViewModel.sections.map { section in
            let sectionViewModel = SectionViewModel(section: section)
            print("Section: \(section.title) has \(section.products.count) number of items")
            return SectionViewController(viewModel: sectionViewModel)
        }
        addSectionViewControllers()
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
