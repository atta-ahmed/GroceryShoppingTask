//
//  ProductUiModel.swift
//  GroceryShoppingTask
//
//  Created by Atta Amed on 7/10/20.
//  Copyright © 2020 Atta Amed. All rights reserved.
//

import Foundation
// MARK: - ProductUIModel
struct ProductUIModel {
    var id: Int?
    var imageURL: String?
    var name: String?
    var pricePerUnit: Double?
    var quantity: Int = 0

    func getTotalQuantity() -> Int{
        return quantity
    }
}
