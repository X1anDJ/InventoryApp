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
    
    var viewModel: SectionViewModel!
    let sectionStackView = UIStackView()
    let titleStackView = UIStackView()
    let titleLabel = UILabel()
    let ruleStackView = UIStackView()
    let ruleLabel = UILabel()
    let storageCollectionContainerView = UIView()
    
    init(viewModel: SectionViewModel!) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        sectionStackView.spacing = 5
        
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        titleStackView.axis = .horizontal
        titleStackView.spacing = 0
        
        ruleStackView.translatesAutoresizingMaskIntoConstraints = false
        ruleStackView.axis = .horizontal
        ruleStackView.spacing = 0
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = viewModel.getSectionTitle()
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        
        ruleLabel.translatesAutoresizingMaskIntoConstraints = false
        var rule = viewModel.getSectionRule()
        ruleLabel.text = "放入起\(rule)日提醒"
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
        
        var itemsPerRow: CGFloat {
            // Check if the device is an iPad
            if UIDevice.current.userInterfaceIdiom == .pad {
                return 6 // For iPad
            } else {
                return 3 // For iPhone
            }
        }
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        let totalSpacing = spacing * (itemsPerRow + 1)
        let cellWidth = (UIScreen.main.bounds.width - totalSpacing) / itemsPerRow

        layout.itemSize = CGSize(width: cellWidth, height: cellWidth + 30)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 0)

        
        let storageCollectionVC = StorageCollectionViewController(viewModel: viewModel, layout: layout)
        
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
