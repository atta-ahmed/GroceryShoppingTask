//
//  BadgeManager.swift
//  GroceryShoppingTask
//
//  Created by Atta Amed on 7/11/20.
//  Copyright © 2020 Atta Amed. All rights reserved.
//

import Foundation
import UIKit

protocol BadgeUpdatable {
}

protocol BadgeNumberProvider {

    func updateBadgeNumber(_ number: String)
}

extension BadgeNumberProvider where Self: UIViewController {

    func updateBadgeNumber(_ number: String) {

        if let tabBarViewControllers = tabBarController?.viewControllers {

            tabBarViewControllers.forEach {
                if $0 is BadgeUpdatable {
                    if number == "" {
                        $0.tabBarItem.badgeValue = nil
                    } else {
                        $0.tabBarItem.badgeValue = number
                    }
                }
            }
        }
    }
}

protocol BadgeNumberManager {
    func updateBadgeNumber(in view: BadgeNumberProvider?, number: String)
}

extension BadgeNumberManager {
    func updateBadgeNumber(in view: BadgeNumberProvider?, number: String) {
        view?.updateBadgeNumber(number)
    }
}
