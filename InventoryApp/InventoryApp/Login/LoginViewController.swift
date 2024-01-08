//
//  ViewController.swift
//  InventoryApp
//
//  Created by Dajun Xian on 2024/1/7.
//


import UIKit

protocol LogoutDelegate: AnyObject {
    func didLogout()
}

protocol LoginViewControllerDelegate: AnyObject {
    func didLogin()
}

class LoginViewController: UIViewController {

    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    
    let loginView = LoginView()
    let continueButton = UIButton(type: .system)
    let divider = DividerView()
    let authButtonsView = AuthenticationButtonsView()
    
    weak var delegate: LoginViewControllerDelegate?
//    
//    var emailAddress: String? {
//        return loginView.emailTextField.text
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        continueButton.configuration?.showsActivityIndicator = false
    }
}

extension LoginViewController {
    
    private func style() {
        view.backgroundColor = .systemBackground
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.text = "一分钟入库"

        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.textAlignment = .center
        subtitleLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        subtitleLabel.adjustsFontForContentSizeCategory = true
        subtitleLabel.numberOfLines = 0
        subtitleLabel.text = "基于AI的库存管理程序"

        loginView.translatesAutoresizingMaskIntoConstraints = false

        continueButton.translatesAutoresizingMaskIntoConstraints = false
        continueButton.configuration = .filled()
        continueButton.configuration?.imagePadding = 8 // for indicator spacing
        continueButton.setTitle("使用手机登录", for: [])
        continueButton.heightAnchor.constraint(equalToConstant: continueButton.frame.height + 50).isActive = true
        continueButton.layer.cornerRadius = 25
        continueButton.clipsToBounds = true
        continueButton.tintColor = UIColor { (traitCollection: UITraitCollection) -> UIColor in
            switch traitCollection.userInterfaceStyle {
                case .dark:
                    return .white  // White color in dark mode
                default:
                    return .black  // Black color in light mode
            }
        }
        continueButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
        
        divider.translatesAutoresizingMaskIntoConstraints = false
        
        authButtonsView.translatesAutoresizingMaskIntoConstraints = false

    }
    
    private func layout() {
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
//        view.addSubview(loginView)
        view.addSubview(continueButton)
        view.addSubview(divider)
        view.addSubview(authButtonsView)
        // view.addSubview(errorMessageLabel)

        // Title
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // Subtitle
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 3),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // AuthButtonsView - Anchored to the bottom
        NSLayoutConstraint.activate([
            authButtonsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            authButtonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            authButtonsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            authButtonsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])

        // Divider - Above AuthButtonsView
        NSLayoutConstraint.activate([
            divider.bottomAnchor.constraint(equalTo: authButtonsView.topAnchor, constant: -20),
            divider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            divider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            divider.heightAnchor.constraint(equalToConstant: 20)
        ])

        // Continue Button - Above Divider
        NSLayoutConstraint.activate([
            continueButton.bottomAnchor.constraint(equalTo: divider.topAnchor, constant: -20),
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
//        // LoginView - Above Continue Button
//        NSLayoutConstraint.activate([
//            loginView.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -20),
//            loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
//        ])
    }

}

// MARK: Actions
extension LoginViewController {
    @objc func signInTapped(sender: UIButton) {
        //errorMessageLabel.isHidden = true
        login()
    }
    
    private func login() {

        
//        if emailAddress == "" {
//            continueButton.configuration?.showsActivityIndicator = true
//            delegate?.didLogin()
//        } else {
//            configureView(withMessage: "Incorrect username / password")
//        }
    }
    
    private func configureView(withMessage message: String) {
        print(message)
    }
}

