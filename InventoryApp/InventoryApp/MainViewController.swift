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

        inventoryVC.setTabBarImage(imageName: "shippingbox.fill", title: "我的库存")
        recipeVC.setTabBarImage(imageName: "frying.pan.fill", title: "菜谱管理")
        
        let inventoryNC = UINavigationController(rootViewController: inventoryVC)
        let recipeNC = UINavigationController(rootViewController: recipeVC)
//
//        inventoryNC.navigationBar.barTintColor = .systemBlue
//        hideNavigationBarLine(inventoryNC.navigationBar)
//        hideNavigationBarLine(recipeNC.navigationBar)
        
        let tabBarList = [inventoryNC, recipeNC]

        viewControllers = tabBarList
    }
    
    private func setupTabBar() {
        tabBar.tintColor = .systemBlue
        tabBar.isTranslucent = false
    }
}
