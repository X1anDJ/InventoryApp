//
//  SectionViewController.swift
//  InventoryApp
//
//  Created by Dajun Xian on 2024/1/13.
//

import Foundation
import Foundation
import UIKit

class SectionViewController: UIViewController {
    
    let sectionStackView = UIStackView()
    
    let titleStackView = UIStackView()
    let titleLabel = UILabel()
    
    let ruleStackView = UIStackView()
    let ruleLabel = UILabel()
    
    let storageCollectionContainerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        addStorageCollectionViewController()
    }
}

extension SectionViewController {
    func style() {
        sectionStackView.translatesAutoresizingMaskIntoConstraints = false
        sectionStackView.axis = .vertical
        sectionStackView.spacing = 2
        
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        titleStackView.axis = .horizontal
        titleStackView.spacing = 0
        
        ruleStackView.translatesAutoresizingMaskIntoConstraints = false
        ruleStackView.axis = .horizontal
        ruleStackView.spacing = 0
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "保鲜区"
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        
        ruleLabel.translatesAutoresizingMaskIntoConstraints = false
        ruleLabel.text = "放入起31日提醒"
        ruleLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        
        storageCollectionContainerView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        // Create spacer views for titleStackView and ruleStackView
        let titleSpacerView = UIView()
        titleSpacerView.translatesAutoresizingMaskIntoConstraints = false
        titleSpacerView.widthAnchor.constraint(equalToConstant: 10).isActive = true

        let ruleSpacerView = UIView()
        ruleSpacerView.translatesAutoresizingMaskIntoConstraints = false
        ruleSpacerView.widthAnchor.constraint(equalToConstant: 10).isActive = true

        // Add the spacers and labels to the stack views
        titleStackView.addArrangedSubview(titleSpacerView)
        titleStackView.addArrangedSubview(titleLabel)

        ruleStackView.addArrangedSubview(ruleSpacerView)
        ruleStackView.addArrangedSubview(ruleLabel)

        // Add both stack views and the container view to the sectionStackView
        sectionStackView.addArrangedSubview(titleStackView)
        sectionStackView.addArrangedSubview(ruleStackView)
        sectionStackView.addArrangedSubview(storageCollectionContainerView)

        // Add sectionStackView to the view
        view.addSubview(sectionStackView)

        NSLayoutConstraint.activate([
            // Constraints for sectionStackView
            sectionStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            sectionStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sectionStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sectionStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            // Constraints for storageCollectionContainerView
            storageCollectionContainerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100)
        ])
    }


    
    func addStorageCollectionViewController() {
        let storageCollectionVC = StorageCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        addChild(storageCollectionVC)
        storageCollectionContainerView.addSubview(storageCollectionVC.view)

        storageCollectionVC.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            storageCollectionVC.view.topAnchor.constraint(equalTo: storageCollectionContainerView.topAnchor),
            storageCollectionVC.view.leadingAnchor.constraint(equalTo: storageCollectionContainerView.leadingAnchor),
            storageCollectionVC.view.trailingAnchor.constraint(equalTo: storageCollectionContainerView.trailingAnchor),
            storageCollectionVC.view.bottomAnchor.constraint(equalTo: storageCollectionContainerView.bottomAnchor)
        ])

        storageCollectionVC.didMove(toParent: self)
    }
}
