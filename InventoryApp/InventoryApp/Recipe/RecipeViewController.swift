//
//  RecipeViewController.swift
//  InventoryApp
//
//  Created by Dajun Xian on 2024/1/7.
//

import UIKit

class RecipeViewController: UIViewController {
    let stackView = UIStackView()
    let label = UILabel()
    
    let logoutButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
        style()
        layout()
    }
}

extension RecipeViewController {
    func style() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Recipe"
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.backgroundColor = .red // Set the background color to red
        logoutButton.setTitleColor(.white, for: .normal) // Set the title color to white for better contrast
        logoutButton.layer.cornerRadius = logoutButton.frame.height / 2 // Make it a round button
        logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)

 
    }
    
    func layout() {
        stackView.addArrangedSubview(label)
        
        stackView.addArrangedSubview(logoutButton)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func logoutTapped() {
        // Here you can call your AppDelegate's didLogout method or any other logout logic
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.didLogout()
        }
    }
}
