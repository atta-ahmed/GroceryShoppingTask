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
    var productHomeViewController: ProductHomeViewControllerSpy!

    override func setUp() {
        super.setUp()
        useCase = ProductsUseCaseMock()
        productHomeViewController = ProductHomeViewControllerSpy()
        sutPresenter = ProductHomePresenter(view: productHomeViewController,
                                            useCase: useCase)
    }

    func testFetchHomeProducts() {
        productHomeViewController.showIndecator()
        XCTAssertTrue(productHomeViewController.isShowIndicator)

        sutPresenter?.fetchHomeProducts()
        XCTAssertEqual(sutPresenter?.products.count, 1)
        XCTAssertEqual(sutPresenter?.products.first?.quantity, 0)

        productHomeViewController.stopIndicator()
        XCTAssertFalse(productHomeViewController.isShowIndicator)
    }

    func testFetchLocalCart() {
        sutPresenter?.fetchLocalCart()
        XCTAssertEqual(sutPresenter?.products.count, 2)
        XCTAssertEqual(sutPresenter?.products.first?.quantity, 1)

        productHomeViewController.updateBadgeNumber("3")
        XCTAssertEqual(productHomeViewController.badgNumber, "3")

        XCTAssertTrue(productHomeViewController.isReloded)
    }

    override func tearDown() {
        super.tearDown()
        useCase = nil
        productHomeViewController = nil
        sutPresenter = nil
    }

}
