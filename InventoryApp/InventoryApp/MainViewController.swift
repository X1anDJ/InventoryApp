//
//  MainViewController.swift
//  InventoryApp
//
//  Created by Dajun Xian on 2024/1/7.
//

import UIKit
class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupTabBar()
    }

    private func setupViews() {
        let inventoryVC = InventoryViewController()
        let recipeVC = RecipeViewController()

        inventoryVC.setTabBarImage(imageName: "list.dash.header.rectangle", title: "Inventory")
        recipeVC.setTabBarImage(imageName: "frying.pan", title: "Recipe")
        
        let inventoryNC = UINavigationController(rootViewController: inventoryVC)
        let recipeNC = UINavigationController(rootViewController: recipeVC)

        inventoryNC.navigationBar.barTintColor = appColor
        hideNavigationBarLine(inventoryNC.navigationBar)
        hideNavigationBarLine(recipeNC.navigationBar)
        
        let tabBarList = [inventoryNC, recipeNC]

        viewControllers = tabBarList
    }
    
    private func hideNavigationBarLine(_ navigationBar: UINavigationBar) {
        let img = UIImage()
        navigationBar.shadowImage = img
        navigationBar.setBackgroundImage(img, for: .default)
        navigationBar.isTranslucent = false
    }
    
    private func setupTabBar() {
        tabBar.tintColor = appColor
        tabBar.isTranslucent = false
    }
}
