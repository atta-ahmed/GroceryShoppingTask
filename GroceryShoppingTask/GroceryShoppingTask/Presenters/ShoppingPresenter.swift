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
    var offset = 0
    var limit = 10
    var products: [Products] = []
    
    func getProducts() {
        let params = ["limit": limit,
                      "offset": offset]
        NetworkHelper.request(url: "products", success: successGetProducts , method: .get, paramter: params)
    }
    
     fileprivate func successGetProducts(response: [Products]){
        for product in response {
            products.append(product)
        }
        offset += products.count
        shoppingDelegate?.onSuccessGetProducts()
    }
}
