//
//  PurchasePresenter.swift
//  GroceryShoppingTask
//
//  Created by Atta Amed on 7/13/20.
//  Copyright © 2020 Atta Amed. All rights reserved.
//

import Foundation

protocol PurchasePresenterProtocol {
    var numberOfCart: Int {get}
    func notfiy()
    func cart(at index: Int) -> ProductUIModel
}

class PurchasePresenter {

    var view: PurchaseViewProtocol
    var cart: [ProductUIModel] = []
    var router: RouterProtocol

    public init(view: PurchaseViewProtocol,
                router: RouterProtocol,
                dataSource: Codable?) {

        self.view = view
        self.router = router

        if let cart = dataSource as? [ProductUIModel] {
            self.cart = cart
        }
    }
}

extension PurchasePresenter: PurchasePresenterProtocol{
    var numberOfCart: Int {
        return cart.count
    }

    func notfiy() {
        view.reloadCartList()
    }

    func cart(at index: Int) -> ProductUIModel {
        return cart[index]
    }


}
