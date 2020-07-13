//
//  GroceryDataStore.swift
//  GroceryShoppingTask
//
//  Created by Atta Amed on 7/10/20.
//  Copyright © 2020 Atta Amed. All rights reserved.
//

import Foundation

protocol ProductRemoteDataStoreProtocol {
    func fetchHomeProductsDataStore(offset: Int, completion: @escaping ([Product]) -> Void)
}

class ProductRemoteDataStore: ProductRemoteDataStoreProtocol {
    func fetchHomeProductsDataStore(offset: Int, completion: @escaping ([Product]) -> Void) {
        let params = ["limit": APIConfig.limit,
                      "offset": offset] as [String : Any]
        NetworkManager.shared.execute(url: "products", method: .get, paramter: params ) { (response) in
            completion(response)
        }
    }
}
