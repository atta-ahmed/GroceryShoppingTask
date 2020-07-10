//
//  SuperPresenter.swift
//  GroceryShoppingTask
//
//  Created by Atta Amed on 7/8/20.
//  Copyright © 2020 Atta Amed. All rights reserved.
//

import Foundation
class SuperPresenter {

    weak var superDelegate: UpdateCartProtocol?

    func updateCarts(withProduct product: Product) {
//        let param = ["id":"db08520c-c151-11ea-b3de-0242ac130004",
//                     "products": ["quantity": 1,
//                                  "product":["id": id]]
//                        ] as [String: Any]
        let cart = Cart()
        cart.id = "db08520c-c151-11ea-b3de-0242ac130004"
        let productElement = ProductElement()
        productElement.quantity = 1
        product.imageURL = nil
        product.name = nil
        product.pricePerUnit = nil
        productElement.product = product


        cart.products.append(productElement)
        
//        let jsonData = try? JSONEncoder().encode(cart)
//        guard let jsonString = String(data: jsonData!, encoding: .utf8) else { return }

        let param = cart.dictionary!

        let headers = [
            "Content-Type":"application/json"
        ]
        NetworkHelper.request(url: "cart", success: successUpdateCart , method: .post, paramter: param, headers: headers )
       }

    fileprivate func successUpdateCart(response: Cart) {
        superDelegate?.onSuccessUpdateCart()
    }
    func jsonToDictionary(from text: String) -> [String: Any]? {
        guard let data = text.data(using: .utf8) else { return nil }
        let anyResult = try? JSONSerialization.jsonObject(with: data, options: [])
        return anyResult as? [String: Any]
    }
}
