//
//  TabBarController.swift
//  GroceryShoppingTask
//
//  Created by Atta Amed on 7/9/20.
//  Copyright © 2020 Atta Amed. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    //MARK:- lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = tabsViewController
        self.title = "Shopping"
    }

    //MARK:- Setup UI
    private func setUpTabBarItem(_ homeViewController: UIViewController,
                                 imageName: String,
                                 title: String) {
        homeViewController.tabBarItem.image = UIImage(systemName: imageName)
        homeViewController.tabBarItem.title = title
    }
    /// tabbar item 
    var tabsViewController: [UIViewController] {
         let homeViewController = GrocoeryConfigurator.home.viewController
         setUpTabBarItem(homeViewController, imageName: "bag", title: "Shopping")

         let cartViewController = GrocoeryConfigurator.cart.viewController
         setUpTabBarItem(cartViewController, imageName: "cart", title: "Cart")

         return[ homeViewController,cartViewController]
     }
}

extension TabBarController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.title = item.title
    }
}
