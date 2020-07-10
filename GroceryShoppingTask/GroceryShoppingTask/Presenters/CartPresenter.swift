//
//  CartPresenter.swift
//  GroceryShoppingTask
//
//  Created by Atta Amed on 7/8/20.
//  Copyright © 2020 Atta Amed. All rights reserved.
//

import Foundation
protocol CartPresenterProtocol {

    var numberOfCart: Int {get}
    func fetchLocalCart()
    func cart(at index: Int) -> CartUiModel
    func didChangeQuantity(at index: Int)
}

class CartPresenter {

     var cart: [CartUiModel] = []
     let useCase: CartUseCase
     public weak var view: CartViewProtocol?

     public init(view: CartViewProtocol,
                 useCase: CartUseCase) {
        self.view = view
        self.useCase = useCase
     }

}

extension CartPresenter: CartPresenterProtocol {
    var numberOfCart: Int {
        return cart.count
    }

    func fetchLocalCart() {
        self.view?.showIndecator()
        useCase.fetchLocalCart { (error, cart) in
            self.cart = cart
            self.view?.reloadCartList()
        }
    }

    func cart(at index: Int) -> CartUiModel {
        return cart[index]
    }

    func didChangeQuantity(at index: Int) {
        //
    }

    
}
