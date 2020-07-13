//
//  CartUseCase.swift
//  GroceryShoppingTask
//
//  Created by Atta Amed on 7/10/20.
//  Copyright © 2020 Atta Amed. All rights reserved.
//

import Foundation

protocol CartUseCaseProtocol {
    func fetchLocalCart(completion: @escaping (Error?, [ProductUIModel]) -> Void)
    func updateLocalCart(_ cart: ProductUIModel, completion: @escaping () -> Void)
    func updateRemoteCart(_ cart: [ProductUIModel], completion: @escaping ([ProductUIModel]) -> Void)

}

class CartUseCase {

    let repositry: CartRepositryProtocol
    let uiModelMapper: UIModelMapper

    init(repositry: CartRepositryProtocol,
         uiModelMapper: UIModelMapper) {

        self.repositry = repositry
        self.uiModelMapper = uiModelMapper
    }

}

extension CartUseCase: CartUseCaseProtocol {

    func fetchLocalCart(completion: @escaping (Error?, [ProductUIModel]) -> Void) {
        repositry.fetchLocalCart { (error, arrayOfCart) in
            let cartUiModel = self.uiModelMapper.convertCartToCartUIModel(cart: arrayOfCart)
            completion(nil, cartUiModel)
        }
    }

    func updateLocalCart(_ cart: ProductUIModel, completion: @escaping () -> Void) {
        let selectedCart = uiModelMapper.convertProductUIModelToCart(model: cart)
        repositry.updateLocalCart(selectedCart) {
            completion()
        }
    }
    func updateRemoteCart(_ cart: [ProductUIModel], completion: @escaping ([ProductUIModel]) -> Void) {
        let paramters = uiModelMapper.convertProductUIModelToCartApiModel(products: cart)
        repositry.updateRemotCart(paramters) { (arrayOfCart) in
            let products = self.uiModelMapper.convertCartToProductUIModel(cart: [arrayOfCart])
            completion(products)
        }
    }
}
