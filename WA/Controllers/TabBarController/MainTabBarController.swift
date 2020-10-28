//
//  MainTabBarController.swift
//  WA
//
//  Created by Pavel Moroz on 27.10.2020.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let searchVC = MainViewController()
        let searchVCNavController = UINavigationController(rootViewController: searchVC)

        let favoritesVC = FavoritesViewController()
        let favoritesVCNavController = UINavigationController(rootViewController: favoritesVC)

        searchVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        favoritesVC.tabBarItem.image = UIImage(systemName: "star.fill")

        viewControllers = [searchVCNavController, favoritesVCNavController]
    }
}
