//
//  AuthenticationButtonsView.swift
//  InventoryApp
//
//  Created by Dajun Xian on 2024/1/8.
//

import Foundation
// AuthenticationButtonsView.swift
import UIKit

protocol AuthenticationButtonsViewDelegate: AnyObject {
    func googleSignInButtonTapped()
    func wechatSignInButtonTapped()
    func facebookSignInButtonTapped()
    func appleSignInButtonTapped()
}


class AuthenticationButtonsView: UIView {
    
    weak var delegate: AuthenticationButtonsViewDelegate?


    let googleSignInButton = CustomButton(type: .custom)
    let wechatSignInButton = CustomButton(type: .custom)
    let facebookSignInButton = CustomButton(type: .custom)
    let appleSignInButton = CustomButton(type: .system) // Using .system for SF Symbols
    
    let stackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
        layoutButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupButtons() {
        // Configure each button with the appropriate image
        googleSignInButton.setImage(UIImage(named: "google-2"), for: .normal)
        wechatSignInButton.setImage(UIImage(named: "wechat"), for: .normal)
        facebookSignInButton.setImage(UIImage(named: "facebook"), for: .normal)
        if let appleLogo = UIImage(systemName: "applelogo") {
            appleSignInButton.setImage(appleLogo, for: .normal)
            appleSignInButton.tintColor = .white
        }
        
        // Common styling for all buttons
        let buttons = [wechatSignInButton, appleSignInButton, googleSignInButton, facebookSignInButton]
        buttons.forEach { button in
            button.imageView?.contentMode = .scaleAspectFit
            button.backgroundColor = .clear
            button.layer.cornerRadius = 22 // Half of height to create a circle
//            button.layer.borderWidth = 1
//            button.layer.borderColor = UIColor.lightGray.cgColor
            button.clipsToBounds = true
            button.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(button)
        }
        appleSignInButton.backgroundColor = .black
        
        // Set button target
        googleSignInButton.addTarget(self, action: #selector(googleButtonTapped), for: .touchUpInside)
        wechatSignInButton.addTarget(self, action: #selector(wechatButtonTapped), for: .touchUpInside)
        facebookSignInButton.addTarget(self, action: #selector(facebookButtonTapped), for: .touchUpInside)
        appleSignInButton.addTarget(self, action: #selector(appleButtonTapped), for: .touchUpInside)
        
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
    }
    
    private func layoutButtons() {
        // Set the height and width constraints for the buttons
        NSLayoutConstraint.activate([
            
            wechatSignInButton.heightAnchor.constraint(equalToConstant: 44),
            wechatSignInButton.widthAnchor.constraint(equalTo: wechatSignInButton.heightAnchor),
            
            googleSignInButton.heightAnchor.constraint(equalToConstant: 44),
            googleSignInButton.widthAnchor.constraint(equalTo: googleSignInButton.heightAnchor),

            facebookSignInButton.heightAnchor.constraint(equalToConstant: 44),
            facebookSignInButton.widthAnchor.constraint(equalTo: facebookSignInButton.heightAnchor),
            
            appleSignInButton.heightAnchor.constraint(equalToConstant: 44),
            appleSignInButton.widthAnchor.constraint(equalTo: appleSignInButton.heightAnchor)
        ])
        
        // Set the constraints for the stack view
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16), // Padding from the leading edge of the view
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16) // Padding from the trailing edge of the view
        ])
    }
    
    
}

extension AuthenticationButtonsView {
    
    @objc private func googleButtonTapped() {
        delegate?.googleSignInButtonTapped()
    }

    @objc private func wechatButtonTapped() {
        delegate?.wechatSignInButtonTapped()
    }

    @objc private func facebookButtonTapped() {
        delegate?.facebookSignInButtonTapped()
    }

    @objc private func appleButtonTapped() {
        delegate?.appleSignInButtonTapped()
    }
}


class CustomButton: UIButton {
    var touchAreaPadding: CGFloat = 22.0
    var imageInset: CGFloat = 0.0 {
        didSet {
            self.imageEdgeInsets = UIEdgeInsets(
                top: imageInset,
                left: imageInset,
                bottom: imageInset,
                right: imageInset
            )
        }
    }

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let largerArea = self.bounds.insetBy(dx: -touchAreaPadding, dy: -touchAreaPadding)
        return largerArea.contains(point)
    }
}
