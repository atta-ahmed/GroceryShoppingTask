//
//  Cart.swift
//  GroceryShoppingTask
//
//  Created by Atta Amed on 7/8/20.
//  Copyright © 2020 Atta Amed. All rights reserved.
//

import Foundation

class Cart: Codable {
    var products: [Product]?
    var id: Int?
    var quantity: Int?
}
