//
//  InventoryViewController.swift
//  InventoryApp
//
//  Created by Dajun Xian on 2024/1/7.
//

import Foundation
import UIKit
class InventoryViewController: UIViewController {
    let stackView = UIStackView()
    let label = UILabel()
    var sectionViewControllers: [SectionViewController] = [] // Instance of SectionViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for _ in 1...2 {
            let sectionViewController = SectionViewController()
            sectionViewControllers.append(sectionViewController)
        }
        
        style()
        layout()
        addSectionViewControllers() // Call the function to add the SectionViewController
    }
}

extension InventoryViewController {
    func style() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 0
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "我的库存"
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        
    }
    
    func layout() {
        // Horizontal stack view
        let horizontalStackView = UIStackView()
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.axis = .horizontal

        // Create a spacer view for the margin
        let spacerView = UIView()
        spacerView.translatesAutoresizingMaskIntoConstraints = false
        spacerView.widthAnchor.constraint(equalToConstant: 10).isActive = true

        // Add the spacer view and label to the horizontal stack view
        horizontalStackView.addArrangedSubview(spacerView)
        horizontalStackView.addArrangedSubview(label)

        // Add the horizontal stack view to the main vertical stack view
        stackView.addArrangedSubview(horizontalStackView)
        
        // Add the main stack view to the view
        view.addSubview(stackView)

        // Set the constraints for the main stack view
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    
    func addSectionViewControllers() {
        for sectionViewController in sectionViewControllers {
            // Add each SectionViewController as a child
            addChild(sectionViewController)
            stackView.addArrangedSubview(sectionViewController.view)
            sectionViewController.view.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                sectionViewController.view.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
                sectionViewController.view.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
                // No height constraint is set; it's assumed the content sizes itself
            ])

            sectionViewController.didMove(toParent: self)
        }
    }
}
