//
//  ProductHomePresenterTests.swift
//  GroceryShoppingTaskTests
//
//  Created by Atta Amed on 7/11/20.
//  Copyright © 2020 Atta Amed. All rights reserved.
//

import Foundation
import XCTest
@testable import GroceryShoppingTask

class ProductHomePresenterTests: XCTestCase {

    var sutPresenter: ProductHomePresenter?
    var useCase: ProductsUseCaseMock!
    var homeViewController: ProductHomeViewControllerSpy!

    override func setUp() {
        super.setUp()
        useCase = ProductsUseCaseMock()
        homeViewController = ProductHomeViewControllerSpy()

        sutPresenter = ProductHomePresenter(view: homeViewController,
                                            useCase: useCase)
    }

    override func tearDown() {
        super.tearDown()
        useCase = nil
        homeViewController = nil
        sutPresenter = nil
    }

}
