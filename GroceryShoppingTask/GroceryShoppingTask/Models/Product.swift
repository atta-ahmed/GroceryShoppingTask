//
//  Products.swift
//  GroceryShoppingTask
//
//  Created by Atta Amed on 7/8/20.
//  Copyright © 2020 Atta Amed. All rights reserved.
//

import Foundation

// MARK: - Product
struct Product: Codable {
    var id: Int?
    var imageURL: String?
    var name: String?
    var pricePerUnit: Double?
}

