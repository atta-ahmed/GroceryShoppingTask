//
//  Router.swift
//  GroceryShoppingTask
//
//  Created by Atta Amed on 7/15/20.
//  Copyright © 2020 Atta Amed. All rights reserved.
//

import Foundation
import UIKit

protocol Routable {

}

protocol RouterProtocol: AnyObject {
    static func instantiateView()-> UIViewController
    func pushToScreen(with data: Codable?)
}


class CartViewRouter: RouterProtocol {

    var view: CartViewProtocol
    init(view: CartViewProtocol) {
        self.view = view
    }

    func pushToScreen(with data: Codable?) {
        let destenasion = CartViewRouter.instantiateView()
        if let navigator = self.view.navigationConroller {
            navigator.pushViewController(destenasion, animated: true)
        }
    }
    
    static func instantiateView() -> UIViewController {
        return GrocoeryConfigurator.purchase.viewController
    }

}

class PurchaseViewRouter: RouterProtocol {

    var view: PurchaseViewProtocol
//    var dataSource: Codable?

    init(view: PurchaseViewProtocol) {
        self.view = view
//        self.dataSource = dtaSource
    }

    func pushToScreen(with data: Codable?) {
//        let destenasion = CartViewRouter.instantiateView()
//        self.view.navigationController.pushViewController(destenasion, animated: true)
    }

    static func instantiateView() -> UIViewController {
        return GrocoeryConfigurator.purchase.viewController
    }

}
