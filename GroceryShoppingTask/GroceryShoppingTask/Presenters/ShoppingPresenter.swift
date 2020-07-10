//
//  ShoppingPresenter.swift
//  GroceryShoppingTask
//
//  Created by Atta Amed on 7/8/20.
//  Copyright © 2020 Atta Amed. All rights reserved.
//

import Foundation

class ShoppingPresenter {

    weak var shoppingDelegate: ShoppingPresenterProtocol?
//    weak var addToCartDelegate: AddAndRemoveFromCartProtocol?
    var offset = 0
    var limit = 10
    var products: [Product] = []
    
    func getProducts() {
        let params = ["limit": limit,
                      "offset": offset]
//        NetworkHelper.request(url: "products", success: successGetProducts , method: .get, paramter: params)
    }

     fileprivate func successGetProducts(response: [Product]){
        for product in response {
            products.append(product)
        }
        offset += products.count
        shoppingDelegate?.onSuccessGetProducts()
    }

//    func AddToCart(id: Int) {
//        let cart = createCart(id: id)
//        addToCartDelegate?.AddToCart(cart: cart)
//    }
//    func removedFromCart(id: Int) {
//        self.products = products.filter{ $0.id != id }
//    }
//
//    func createCart(id: Int) -> Cart{
//        let newCart = Cart()
//        let newElement = ProductElement()
//        newElement.quantity = 1
//        newElement.product?.id = id
//        newCart.products.append(newElement)
//
//        return newCart
//    }
}
