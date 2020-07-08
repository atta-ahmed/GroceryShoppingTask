//
//  CartPresenter.swift
//  GroceryShoppingTask
//
//  Created by Atta Amed on 7/8/20.
//  Copyright © 2020 Atta Amed. All rights reserved.
//

import Foundation

class CartPresenter {

    weak var cartDelegate: CartProtocol?
    var carts: [Cart] = []

    func getCarts() {
        NetworkHelper.request(url: "cart", success: successGetCarts , method: .get, paramter: ["id":"db08520c-c151-11ea-b3de-0242ac130004"])
    }

    func updateCarts() {
           NetworkHelper.request(url: "cart", success: successGetCarts , method: .post, paramter: [:])
       }

     fileprivate func successGetCarts(carts: [Cart]){
        for cart in carts {
            self.carts.append(cart)
        }
        cartDelegate?.onSuccessGetCart()
    }
}
