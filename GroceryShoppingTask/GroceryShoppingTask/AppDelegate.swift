//
//  AppDelegate.swift
//  GroceryShoppingTask
//
//  Created by Atta Amed on 7/7/20.
//  Copyright © 2020 Atta Amed. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        /// 
        window = UIWindow(frame: UIScreen.main.bounds)
        UIApplication.shared.delegate?.window??.rootViewController = GrocoeryConfigurator.tabbarController.viewController
        UIApplication.shared.delegate?.window??.makeKeyAndVisible()

        return true
    }


}

