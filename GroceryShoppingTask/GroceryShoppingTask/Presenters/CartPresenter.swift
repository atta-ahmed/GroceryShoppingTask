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
    func didChangeQuantity(whereID id: Int, isIncrease: Bool)
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

    func didChangeQuantity(whereID id: Int, isIncrease: Bool) {
        if var selectedCart = cart.first(where: { $0.id == id }) {
            if isIncrease {
                selectedCart.quantity += 1
            } else {
                selectedCart.quantity -= 1
            }
            useCase.updateCart(selectedCart) {
                self.fetchLocalCart()
            }
        }
    }
    
}
