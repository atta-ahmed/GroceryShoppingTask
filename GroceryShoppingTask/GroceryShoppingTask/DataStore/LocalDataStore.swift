//
//  ProductLocalDataStore.swift
//  GroceryShoppingTask
//
//  Created by Atta Amed on 7/10/20.
//  Copyright © 2020 Atta Amed. All rights reserved.
//

import Foundation

protocol LocalDataStoreProtocol {
    func updateLocalCartsDataStore(_ cart: Cart, completion: @escaping () -> Void)
    func fetchLocalCart(completion: @escaping ([Cart]) -> Void)

}
class LocalDataStore: LocalDataStoreProtocol {

    func fetchLocalCart(completion: @escaping ([Cart]) -> Void) {
        let defaults = UserDefaults.standard
        guard let cart = defaults.decode(for: [Cart].self, using: "allSavedCart") else { return }
        
        completion(cart)
    }

    func updateLocalCartsDataStore(_ cart: Cart, completion: @escaping () -> Void) {
        let defaults = UserDefaults.standard
        if var cartArray = defaults.decode(for: [Cart].self, using: "allSavedCart") {
            if defaults.cartExists(id: cart.products.first?.product?.id ?? 0, key: "allSavedCart") {
                for (i, updatedObject) in cartArray.enumerated() {
                    let cart = updatedObject as Cart
                    if cart.products.first?.product?.id == updatedObject.products.first?.product?.id {
                        cartArray[i].products[0].quantity = cart.products.first?.quantity
                    }
                }
                defaults.encode(for: cartArray, using: "allSavedCart")
            } else {
                cartArray.append(cart)
                defaults.encode(for: cartArray, using: "allSavedCart")
            }
        } else {
            defaults.encode(for: [cart], using: "allSavedCart")
        }
        completion()
        print("done")
    }

}
