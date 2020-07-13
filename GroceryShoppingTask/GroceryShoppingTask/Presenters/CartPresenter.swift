//
//  CartPresenter.swift
//  GroceryShoppingTask
//
//  Created by Atta Amed on 7/8/20.
//  Copyright © 2020 Atta Amed. All rights reserved.
//

import Foundation
//MARK:- Protocol
protocol CartPresenterProtocol: BadgeNumberManager {
    var numberOfCart: Int {get}
    func fetchLocalCart()
    func cart(at index: Int) -> ProductUIModel
    func didChangeQuantity(whereID id: Int, isIncrease: Bool)
    func updateRmoteCart()
}

class CartPresenter {

    //MARK:- properties
     var cart: [ProductUIModel] = []
     let useCase: CartUseCase
    var totalQuantity: String {
        let count = cart.reduce(0) { $0 + $1.quantity }
        return  count > 0 ? "\(count)" : ""
    }

     public weak var view: CartViewProtocol?

    //MARK:- Init
     public init(view: CartViewProtocol,
                 useCase: CartUseCase) {
        self.view = view
        self.useCase = useCase
     }

}

//MARK:- Handle UI logic
extension CartPresenter: CartPresenterProtocol {
    var numberOfCart: Int {
        return cart.count
    }

    /// fetch only local data to update quantity
    func fetchLocalCart() {
        self.view?.showIndecator()
        useCase.fetchLocalCart { (error, cart) in
            self.cart = cart
            self.view?.stopIndicator()
            self.view?.reloadCartList()
            self.updateBadgeNumber(in: self.view, number: self.totalQuantity)
        }
    }
    func updateRmoteCart() {
        useCase.updateRemoteCart(cart) { (arrayOfCart) in 
            self.view?.gotoPurchase()
        }

    }
    /// handle +,- buttons
    func didChangeQuantity(whereID id: Int, isIncrease: Bool) {
        if var selectedCart = cart.first(where: { $0.id == id }) {
            if isIncrease {
                selectedCart.quantity += 1
            } else {
                selectedCart.quantity -= 1
            }
            useCase.updateLocalCart(selectedCart) {
                self.fetchLocalCart()
            }
        }
    }
    func cart(at index: Int) -> ProductUIModel {
        return cart[index]
    }
}
