//
//  ProductHomeViewControllerSpy.swift
//  GroceryShoppingTaskTests
//
//  Created by Atta Amed on 7/11/20.
//  Copyright © 2020 Atta Amed. All rights reserved.
//

import Foundation
@testable import GroceryShoppingTask

class ProductHomeViewControllerSpy: ProductHomeViewProtocol {

    var isShowIndicator = false
    var isReloded = false
    var isCartUpdated = false
    var badgNumber = ""

    func showIndecator() {
        isShowIndicator = true
    }

    func stopIndicator() {
        isShowIndicator = false
    }

    func reloadProductsList() {
        isReloded = true
    }

    func cartUpdated() {
        isCartUpdated = true
    }

    func updateBadgeNumber(_ number: String) {
        badgNumber = number
    }
}
