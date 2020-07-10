//
//  CartUseCase.swift
//  GroceryShoppingTask
//
//  Created by Atta Amed on 7/10/20.
//  Copyright © 2020 Atta Amed. All rights reserved.
//

import Foundation

protocol CartUseCaseProtocol {
    func fetchLocalCart(completion: @escaping (Error?, [CartUiModel]) -> Void)
    func updateCart(_ cart: CartUiModel, completion: @escaping () -> Void)
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

    func fetchLocalCart(completion: @escaping (Error?, [CartUiModel]) -> Void) {
        repositry.fetchLocalCart { (error, arrayOfCart) in
            let cartUiModel = self.uiModelMapper.convertCartToCartUIModel(cart: arrayOfCart)
            completion(nil, cartUiModel)
        }
    }

    func updateCart(_ cart: CartUiModel, completion: @escaping () -> Void) {
        let selectedCart = uiModelMapper.convertCartUIModelToCart(model: cart)
        repositry.updateCart(selectedCart) {
            completion()
        }
    }
}
