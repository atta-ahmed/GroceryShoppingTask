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
    func updateRemoteCart(_ paramters: [String: Any], completion: @escaping ([Cart]) -> Void)
}

class CartRemoteDataStore: CartRemoteDataStoreProtocol {

    func updateRemoteCart(_ paramters: [String: Any], completion: @escaping ([Cart]) -> Void) {
//        let jsonData = try! JSONSerialization.data(withJSONObject: paramters, options: [])
//        let decoded = String(data: jsonData, encoding: .utf8)!
//        let params = paramters
        let header = ["Content-Type": "application/json"]

        NetworkManager.execute(url: "cart", method: .post, paramter: paramters, header: header) { (result) in
            completion(result)
        }
    }

    func dictToJSON(dict:[String: Any]) -> Any {
        let jsonData = try! JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
        let decoded = try! JSONSerialization.jsonObject(with: jsonData, options: [])
        return decoded
    }

    func arrayToJSON(array:[String]) -> Any {
        let jsonData = try! JSONSerialization.data(withJSONObject: array, options: .prettyPrinted)
        let decoded = try! JSONSerialization.jsonObject(with: jsonData, options: [])
        return decoded
    }

    func fetchRemoteCart(completion: @escaping ([Cart]) -> Void) {
        let params = ["id": GroceryAPIConfig.id] as [String : Any]
        NetworkManager.execute(url: "cart", method: .get, paramter: params) { (response) in
            completion(response)
        }
    }
}
