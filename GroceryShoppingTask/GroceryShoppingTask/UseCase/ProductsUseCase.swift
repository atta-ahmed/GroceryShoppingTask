//
//  ProductsUseCase.swift
//  GroceryShoppingTask
//
//  Created by Atta Amed on 7/10/20.
//  Copyright © 2020 Atta Amed. All rights reserved.
//

import Foundation
protocol ProductsUseCaseProtocol {
    func featchData(offset: Int, completion: @escaping (Error?, [ProductUIModel]) -> Void)
    func updateLocalCart(_ cart: ProductUIModel, completion: @escaping () -> Void)
    func fetchLocalCart(currentProduct: [ProductUIModel], completion: @escaping (Error?, [ProductUIModel]) -> Void)
    
}

class ProductsUseCase {

    let repositry: ProductsRepositoryProtocol
    let uiModelMapper: UIModelMapper

    init(repositry: ProductsRepositoryProtocol,
         uiModelMapper: UIModelMapper) {

        self.repositry = repositry
        self.uiModelMapper = uiModelMapper
    }

}

extension ProductsUseCase: ProductsUseCaseProtocol {
    func fetchLocalCart(currentProduct: [ProductUIModel], completion: @escaping (Error?, [ProductUIModel]) -> Void) {
        var localPoducts: [ProductUIModel] = []
        var allProducts: [ProductUIModel] = []
        repositry.fetchLocalCart { (error, arrayOfCart) in
            localPoducts = self.uiModelMapper.convertCartToProductUIModel(cart: arrayOfCart)

            allProducts = self.uiModelMapper.updateQuantityOfProducts(localPoducts: localPoducts,
                                                                      remoteProducts: currentProduct)
            completion(nil, allProducts)
        }

    }


    func featchData(offset: Int, completion: @escaping (Error?, [ProductUIModel]) -> Void) {
        var remoteProducts: [ProductUIModel] = []
        var localPoducts: [ProductUIModel] = []
        var allProducts: [ProductUIModel] = []

        repositry.featchProducts(offset: offset) { (error, products) in
            remoteProducts = self.uiModelMapper.convertProductToUIModel(products: products)
            self.repositry.fetchLocalCart { [weak self] (error, arrayOfCart) in
                guard let self = self else { return }
                localPoducts = self.uiModelMapper.convertCartToProductUIModel(cart: arrayOfCart)
            }

            allProducts = self.uiModelMapper.updateQuantityOfProducts(localPoducts: localPoducts,
                                                                      remoteProducts: remoteProducts)
            completion(nil, allProducts)
        }
    }

    func updateLocalCart(_ product: ProductUIModel, completion: @escaping () -> Void) {
        let cart = uiModelMapper.convertProductUIModelToCart(model: product)
        repositry.updateCarts(cart) {
            completion()
        }
    }

}
