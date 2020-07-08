//
//  ShoppingPresenterTests.swift
//  GroceryShoppingTaskTests
//
//  Created by Atta Amed on 7/8/20.
//  Copyright © 2020 Atta Amed. All rights reserved.
//

import Foundation
import XCTest
@testable import GroceryShoppingTask

class ShoppingPresenterTests: XCTestCase {

    var presenter: ShoppingPresenter?

    override func setUp() {
        super.setUp()
        presenter = ShoppingPresenter()
    }

    func testSetUp(){
        XCTAssertEqual(presenter?.limit, 10)
        XCTAssertEqual(presenter?.offset, presenter?.products.count)
    }

    override func tearDown() {
        super.tearDown()
    }

}
