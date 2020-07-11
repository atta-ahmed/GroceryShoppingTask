//
//  CartApiModel.swift
//  GroceryShoppingTask
//
//  Created by Atta Amed on 7/10/20.
//  Copyright © 2020 Atta Amed. All rights reserved.
//

import Foundation

// Api request models
struct CartApiModel {
    var id: String
    var products: [ProductApiModel]

    func toJSON() -> [String: Any] {
        return [
            "id": id as Any,
            "products": products.map{$0.toJSON()} as Any
        ]
    }
}

struct ProductApiModel{
    var quantity: Int?
    var product: ProductModel?

    func toJSON() -> [String: Any] {
        return [
            "quantity": quantity as Any,
            "product": product?.toJSON() as Any
        ]
    }
}

struct ProductModel {
    var id: Int?
    func toJSON() -> [String: Any] {
        return [
            "id": id as Any
        ]
    }
}
