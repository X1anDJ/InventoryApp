//
//  SectionViewModel.swift
//  InventoryApp
//
//  Created by Dajun Xian on 2024/1/19.
//

import UIKit
class SectionViewController: UIViewController {
    
    var viewModel: SectionViewModel!
    
    // UI Elements
    let sectionStackView = UIStackView()
    let titleStackView = UIStackView()
    let titleLabel = UILabel()
    let ruleStackView = UIStackView()
    let sectionRuleLabel = UILabel()
    let sortDateButton = UIButton(type: .system)
    let sortQuantityButton = UIButton(type: .system)
    let storageCollectionContainerView = UIView()

    // MARK: - Initialization
    init(viewModel: SectionViewModel!) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        setupButtons()
        updateButtonAppearanceAndSymbols()
        addStorageCollectionViewController()

        print("Label font size: \(sectionRuleLabel.font.pointSize)")
        print("Button font size: \(sortDateButton.titleLabel?.font.pointSize ?? 0)")

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateButtonAppearanceAndSymbols()
    }

    // MARK: - UI Configuration

    private func style() {
        titleLabel.text = viewModel.getSectionTitle()
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        
        sectionRuleLabel.text = "放入起\(viewModel.getSectionRule())日提醒"
        //sectionRuleLabel.font = UIFont.preferredFont(forTextStyle: .caption1)

        [sectionStackView, titleStackView, ruleStackView, storageCollectionContainerView, sortDateButton, sortQuantityButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    private func layout() {
        layoutTitleStackView()
        layoutRuleStackView()
        layoutSectionStackView()
        layoutStorageCollectionContainerView()
    }

    private func layoutTitleStackView() {
        titleStackView.addArrangedSubview(createSpacerView())
        titleStackView.addArrangedSubview(titleLabel)
    }

    private func layoutRuleStackView() {
        ruleStackView.addArrangedSubview(createSpacerView())
        ruleStackView.addArrangedSubview(sectionRuleLabel)
        ruleStackView.addArrangedSubview(UIView()) // Filler view for spacing
        ruleStackView.addArrangedSubview(sortDateButton)
        ruleStackView.addArrangedSubview(createSpacerView(width: 10))
        ruleStackView.addArrangedSubview(sortQuantityButton)
        ruleStackView.alignment = .fill
        NSLayoutConstraint.activate([
            ruleStackView.heightAnchor.constraint(equalToConstant: 15),
            sortDateButton.heightAnchor.constraint(equalToConstant: 15),
            sortQuantityButton.heightAnchor.constraint(equalToConstant: 15),
        ])
        
        sectionRuleLabel.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .vertical)
        sectionRuleLabel.setContentCompressionResistancePriority(UILayoutPriority.required, for: .vertical)
        
        

    }

    private func layoutSectionStackView() {
        sectionStackView.axis = .vertical
        sectionStackView.spacing = 5
        sectionStackView.addArrangedSubview(titleStackView)
        sectionStackView.addArrangedSubview(ruleStackView)
        sectionStackView.addArrangedSubview(storageCollectionContainerView)
        view.addSubview(sectionStackView)

        NSLayoutConstraint.activate([
            sectionStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            sectionStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sectionStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sectionStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func layoutStorageCollectionContainerView() {
        storageCollectionContainerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
    }

    private func createSpacerView(width: CGFloat = 10) -> UIView {
        let spacerView = UIView()
        spacerView.widthAnchor.constraint(equalToConstant: width).isActive = true
        return spacerView
    }

    // MARK: - Button Setup and Actions
    private func setupButtons() {
        setupButton(sortDateButton, title: "日期", imageName: "upArrow")
        setupButton(sortQuantityButton, title: "数量", imageName: "upArrow")

        sortDateButton.addTarget(self, action: #selector(sortDateButtonTapped), for: .touchUpInside)
        sortQuantityButton.addTarget(self, action: #selector(sortQuantityButtonTapped), for: .touchUpInside)
    }

    private func setupButton(_ button: UIButton, title: String, imageName: String) {
        if let image = UIImage(named: imageName) {
            let scaledImage = image.withRenderingMode(.alwaysOriginal)

            var config = UIButton.Configuration.plain()
            config.title = title
            config.image = scaledImage
            config.imagePlacement = .trailing
            config.imagePadding = 10
            
            button.configuration = config
            button.imageView?.clipsToBounds = true
            button.imageView?.contentMode = .scaleAspectFill
        }
    }
    
    
    private func updateButtonAppearanceAndSymbols() {
        switch viewModel.sortingRule {
        case .newestToOldest, .oldestToNewest:
            setActiveAppearance(for: sortDateButton, isActive: true, imageName: viewModel.sortingRule == .newestToOldest ? "upArrow" : "downArrow")
            setActiveAppearance(for: sortQuantityButton, isActive: false, imageName: "grayArrow")
        case .quantityLowToHigh, .quantityHighToLow:
            setActiveAppearance(for: sortDateButton, isActive: false, imageName: "grayArrow")
            setActiveAppearance(for: sortQuantityButton, isActive: true, imageName: viewModel.sortingRule == .quantityLowToHigh ? "upArrow" : "downArrow")
        }
        view.layoutIfNeeded()
    }

    @objc func sortDateButtonTapped() {
        viewModel.sortProducts(rule: viewModel.sortingRule == .newestToOldest ? .oldestToNewest : .newestToOldest)
        setActiveAppearance(for: sortDateButton, isActive: true, imageName: viewModel.sortingRule == .newestToOldest ? "upArrow" : "downArrow")
        setActiveAppearance(for: sortQuantityButton, isActive: false, imageName: "grayArrow")
        reloadCollectionView()
    }

    @objc func sortQuantityButtonTapped() {
        viewModel.sortProducts(rule: viewModel.sortingRule == .quantityLowToHigh ? .quantityHighToLow : .quantityLowToHigh)
        setActiveAppearance(for: sortQuantityButton, isActive: true, imageName: viewModel.sortingRule == .quantityLowToHigh ? "upArrow" : "downArrow")
        setActiveAppearance(for: sortDateButton, isActive: false, imageName: "grayArrow")
        reloadCollectionView()
    }

    private func setActiveAppearance(for button: UIButton, isActive: Bool, imageName: String) {
        if let image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal) {
            button.setImage(image, for: .normal)
//            button.imageView?.clipsToBounds = true
//            button.imageView?.contentMode = .scaleAspectFill

        }

        button.tintColor = isActive ? .black : .gray
        button.setTitleColor(isActive ? .black : .gray, for: .normal)
    }




    private func reloadCollectionView() {
        if let storageCollectionVC = children.first(where: { $0 is StorageCollectionViewController }) as? StorageCollectionViewController {
            storageCollectionVC.collectionView.reloadData()
        }
    }

    // MARK: - Adding Child View Controllers
    private func addStorageCollectionViewController() {
        let storageCollectionVC = StorageCollectionViewController(viewModel: viewModel)
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
