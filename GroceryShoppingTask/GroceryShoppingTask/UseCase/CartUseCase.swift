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
        repositry.fetchLocalCart { [weak self](error, arrayOfCart) in
            guard let self = self else { return }
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
        repositry.updateRemotCart(paramters) { [weak self] (arrayOfCart) in
            guard let self = self else { return }
            let products = self.uiModelMapper.convertCartToProductUIModel(cart: [arrayOfCart])
            completion(products)
        }
    }
}
