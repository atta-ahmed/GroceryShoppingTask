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
    static func instantiateView(dataSource: Codable?)-> UIViewController
    func pushToScreen(with data: Codable?)
}


class CartViewRouter: RouterProtocol {

    var view: CartViewProtocol
    init(view: CartViewProtocol) {
        self.view = view
    }

    func pushToScreen(with data: Codable?) {
        let destenasion = CartViewRouter.instantiateView(dataSource: data)
        if let navigator = self.view.navigationConroller {
            navigator.pushViewController(destenasion, animated: true)
        }
    }
    
    static func instantiateView(dataSource: Codable?) -> UIViewController {
        return GrocoeryConfigurator.purchase(dataSource: dataSource).viewController
    }

}

class PurchaseViewRouter: RouterProtocol {

    var view: PurchaseViewProtocol

    init(view: PurchaseViewProtocol) {
        self.view = view
    }

    func pushToScreen(with data: Codable?) {
//        let destenasion = CartViewRouter.instantiateView()
//        self.view.navigationController.pushViewController(destenasion, animated: true)
    }

    static func instantiateView(dataSource: Codable?) -> UIViewController {
        return GrocoeryConfigurator.purchase(dataSource: nil).viewController
    }

}
