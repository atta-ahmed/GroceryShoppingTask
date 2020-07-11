//
//  CartApiModel.swift
//  GroceryShoppingTask
//
//  Created by Atta Amed on 7/10/20.
//  Copyright © 2020 Atta Amed. All rights reserved.
//

import Foundation

// Api request models
protocol JSONAble {}

extension JSONAble {
    func toDict() -> [String:Any] {
        var dict = [String:Any]()
        let otherSelf = Mirror(reflecting: self)
        for child in otherSelf.children {
            if let key = child.label {
                dict[key] = child.value
            }
        }
        return dict
    }
}

struct CartApiModel: Codable {
    var id: String?
    var products: [ProductApiModel] = []

    enum CodingKeys: String, CodingKey {
        case id
        case products
    }

    init(id: String, products: [ProductApiModel]){
        self.id = id
        self.products = products
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(String.self, forKey: .id)
        products = try container.decode([ProductApiModel].self, forKey: .products)

    }

}

struct ProductApiModel: Codable{
    var quantity: Int
    var product: ProductModel

    enum CodingKeys: String, CodingKey {
        case quantity
        case product
    }
    init(quantity: Int, product: ProductModel){
        self.quantity = quantity
        self.product = product
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        quantity = try container.decode(Int.self, forKey: .quantity)
        product = try container.decode(ProductModel.self, forKey: .product)

    }
}

struct ProductModel: Codable{
    var id: Int

    enum CodingKeys: String, CodingKey {
        case id
    }

    init(id: Int){
        self.id = id
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
    }
}
