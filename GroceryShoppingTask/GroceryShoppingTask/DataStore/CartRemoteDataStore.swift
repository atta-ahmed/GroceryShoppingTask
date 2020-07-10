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
    func updateRemoteCart(completion: @escaping ([Cart]) -> Void)
}

class CartRemoteDataStore: CartRemoteDataStoreProtocol {

    func updateRemoteCart(completion: @escaping ([Cart]) -> Void) {
        let params = ["id": "db08520c-c151-11ea-b3de-0242ac130004"] as [String : Any]
        NetworkManager.execute(url: "cart", method: .post, paramter: params) { (result) in
            completion(result)
        }
    }

    func fetchRemoteCart(completion: @escaping ([Cart]) -> Void) {
        let params = ["id": "db08520c-c151-11ea-b3de-0242ac130004"] as [String : Any]
        NetworkManager.execute(url: "cart", method: .get, paramter: params) { (response) in
            completion(response)
        }
    }

}
