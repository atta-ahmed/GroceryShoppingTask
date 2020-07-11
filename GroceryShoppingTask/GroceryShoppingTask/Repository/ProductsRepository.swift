//
//  ProductsRepository.swift
//  GroceryShoppingTask
//
//  Created by Atta Amed on 7/9/20.
//  Copyright © 2020 Atta Amed. All rights reserved.
//

import Foundation

protocol  ProductsRepositoryProtocol {
    func featchProducts(offset: Int, completion: @escaping (Error?, [Product]) -> Void)
    func fetchLocalCart(completion: @escaping (Error?, [Cart]) -> Void)
    func updateCarts(_ cart: Cart, completion: @escaping () -> Void)
}

class ProductsRepository {
    let remoteDataStore: ProductRemoteDataStoreProtocol
    let localDataStore: LocalDataStoreProtocol

    init(remoteDataStore: ProductRemoteDataStoreProtocol,
         localDataStore: LocalDataStoreProtocol) {
        self.localDataStore = localDataStore
        self.remoteDataStore = remoteDataStore
    }
}

extension ProductsRepository: ProductsRepositoryProtocol {
    func featchProducts(offset: Int, completion: @escaping (Error?, [Product]) -> Void) {
        remoteDataStore.fetchHomeProductsDataStore(offset: offset) { (response) in
            completion(nil, response)
        }
    }

    func fetchLocalCart(completion: @escaping (Error?, [Cart]) -> Void) {
        localDataStore.fetchLocalCart { (allCart) in
            completion(nil, allCart)
        }
    }
    func updateCarts(_ cart: Cart, completion: @escaping () -> Void) {
        localDataStore.updateLocalCartsDataStore(cart) {
            completion()
        }
    }
}
