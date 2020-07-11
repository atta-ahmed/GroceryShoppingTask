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
        let ProductMock = ProductUIModel(id: 1,
                                         imageURL: "http://",
                                         name: "test",
                                         pricePerUnit: 10.2,
                                         quantity: 0)
        completion(nil, [ProductMock])
    }

    func updateLocalCart(_ cart: ProductUIModel, completion: @escaping () -> Void) {
        //
    }

    func fetchLocalCart(currentProduct: [ProductUIModel], completion: @escaping (Error?, [ProductUIModel]) -> Void) {
        let ProductMock = [ProductUIModel(id: 3,
                                          imageURL: "http://",
                                          name: "test2",
                                          pricePerUnit: 10.2,
                                          quantity: 1),
                           ProductUIModel(id: 2,
                                          imageURL: "http://",
                                          name: "test3",
                                          pricePerUnit: 10.2,
                                          quantity: 1)]

        completion(nil, ProductMock)
    }


}
