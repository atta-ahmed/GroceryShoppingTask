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
    func updateCart(_ cart: Cart, completion: @escaping () -> Void)
    func updateRemotCart(_ paramters: [String: Any], completion: @escaping ()-> Void)
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
    func updateRemotCart(_ paramters: [String: Any], completion: @escaping () -> Void) {
        remoteDataStore.updateRemoteCart(paramters) { (_) in
            completion()
        }
    }

    func fetchLocalCart(completion: @escaping (Error?, [Cart]) -> Void) {
        localDataStore.fetchLocalCart { (arrayOfCart) in
            completion(nil, arrayOfCart)
        }
    }
    
    func updateCart(_ cart: Cart, completion: @escaping () -> Void) {
        localDataStore.updateLocalCartsDataStore(cart) {
            completion()
        }
    }
}
