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
    func notfiyByCart()
    func cart(at index: Int) -> ProductUIModel
}

class PurchasePresenter {

    var view: PurchaseViewProtocol
    var cart: [ProductUIModel] = []
    var router: RouterProtocol

    public init(view: PurchaseViewProtocol,
                router: RouterProtocol) {
       self.view = view
        self.router = router
    }
}

extension PurchasePresenter: PurchasePresenterProtocol{
    var numberOfCart: Int {
        //
        return 5
    }

    func notfiyByCart() {
        //
    }

    func cart(at index: Int) -> ProductUIModel {
        return cart.first!
    }


}
