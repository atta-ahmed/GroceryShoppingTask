//
//  ProductsUseCaseMock.swift
//  GroceryShoppingTaskTests
//
//  Created by Atta Amed on 7/11/20.
//  Copyright © 2020 Atta Amed. All rights reserved.
//

import Foundation
@testable import GroceryShoppingTask


struct ProductsUseCaseMock: ProductsUseCaseProtocol {
    func featchData(offset: Int, completion: @escaping (Error?, [ProductUIModel]) -> Void) {
        //
    }

    func updateLocalCart(_ cart: ProductUIModel, completion: @escaping () -> Void) {
        //
    }

    func fetchLocalCart(currentProduct: [ProductUIModel], completion: @escaping (Error?, [ProductUIModel]) -> Void) {
        //
    }


}
