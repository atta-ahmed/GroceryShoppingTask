//
//  Cart.swift
//  GroceryShoppingTask
//
//  Created by Atta Amed on 7/8/20.
//  Copyright © 2020 Atta Amed. All rights reserved.
//

import Foundation


struct Cart: Codable {
    var id: String?
    var products: [ProductElement] = []
    
}

// MARK: - ProductElement
struct ProductElement: Codable {
    var quantity: Int?
    var product: Product?
}
