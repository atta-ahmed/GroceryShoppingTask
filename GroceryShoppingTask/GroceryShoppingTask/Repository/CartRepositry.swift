//
//  CartRepositry.swift
//  GroceryShoppingTask
//
//  Created by Atta Amed on 7/10/20.
//  Copyright © 2020 Atta Amed. All rights reserved.
//

import Foundation

protocol  CartRepositryProtocol {
    func fetchLocalCart(completion: @escaping (Error?, [Cart]) -> Void)
    func updateLocalCart(_ cart: Cart, completion: @escaping () -> Void)
    func updateRemotCart(_ cart: CartApiModel, completion: @escaping (Cart)-> Void)
}

class CartRepositry {

    let remoteDataStore: CartRemoteDataStoreProtocol
    let localDataStore: LocalDataStoreProtocol

    init(remoteDataStore: CartRemoteDataStoreProtocol,
         localDataStore: LocalDataStoreProtocol) {
        self.localDataStore = localDataStore
        self.remoteDataStore = remoteDataStore
    }
}

extension CartRepositry: CartRepositryProtocol {
    func updateRemotCart(_ cart: CartApiModel, completion: @escaping (Cart) -> Void) {
        remoteDataStore.updateRemoteCart(cart) { (arrayOfCart) in
            completion(arrayOfCart)
        }
    }

    func fetchLocalCart(completion: @escaping (Error?, [Cart]) -> Void) {
        localDataStore.fetchLocalCart { (arrayOfCart) in
            completion(nil, arrayOfCart)
        }
    }
    
    func updateLocalCart(_ cart: Cart, completion: @escaping () -> Void) {
        localDataStore.updateLocalCartsDataStore(cart) {
            completion()
        }
    }
}
