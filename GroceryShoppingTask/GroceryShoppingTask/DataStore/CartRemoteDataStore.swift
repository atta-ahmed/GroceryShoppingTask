//
//  CartRemoteDataStore.swift
//  GroceryShoppingTask
//
//  Created by Atta Amed on 7/10/20.
//  Copyright © 2020 Atta Amed. All rights reserved.
//

import Foundation
protocol CartRemoteDataStoreProtocol {
    func fetchRemoteCart(completion: @escaping ([Cart]) -> Void)
    func updateRemoteCart(_ cart: CartApiModel, completion: @escaping ([Cart]) -> Void)
}

class CartRemoteDataStore: CartRemoteDataStoreProtocol {

    func updateRemoteCart(_ cart: CartApiModel, completion: @escaping ([Cart]) -> Void) {
        let params = cart.toJSON()
        let header = ["Content-Type": "application/json"]

        NetworkManager.execute(url: "cart", method: .post, paramter: params, header: header) { (result) in
            completion(result)
        }
    }

    func fetchRemoteCart(completion: @escaping ([Cart]) -> Void) {
        let params = ["id": GroceryAPIConfig.id] as [String : Any]
        NetworkManager.execute(url: "cart", method: .get, paramter: params) { (response) in
            completion(response)
        }
    }
}
