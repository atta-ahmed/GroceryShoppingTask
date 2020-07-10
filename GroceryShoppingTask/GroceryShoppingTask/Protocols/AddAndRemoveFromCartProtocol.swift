//
//  AddAndRemoveFromCartProtocol.swift
//  GroceryShoppingTask
//
//  Created by Atta Amed on 7/9/20.
//  Copyright © 2020 Atta Amed. All rights reserved.
//

import Foundation

protocol AddAndRemoveFromCartProtocol: class {
    func AddToCart(cart: Cart)
    func deleteFromCart(id: Int)
}
