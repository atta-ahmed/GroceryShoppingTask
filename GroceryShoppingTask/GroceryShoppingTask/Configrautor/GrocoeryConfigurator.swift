//
//  GrocoeryConfigurator.swift
//  GroceryShoppingTask
//
//  Created by Atta Amed on 7/9/20.
//  Copyright © 2020 Atta Amed. All rights reserved.
//

import Foundation
import UIKit

protocol GrocoeryConfiguratorProtocol {
    var viewController: UIViewController { get }
}

enum GrocoeryConfigurator {
    case home
    case cart
    case tabbarController
}


extension GrocoeryConfigurator: GrocoeryConfiguratorProtocol {

    var viewController: UIViewController {
        switch self {
        case .home:
            let homeViewController = HomeViewController()
            let remoteDataStore = ProductRemoteDataStore()
            let localDataStore = LocalDataStore()
            let uiModel = UIModelMapper()
            let repositry = ProductsRepository(remoteDataStore: remoteDataStore,
                                               localDataStore: localDataStore)
            let useCase = ProductsUseCase(repositry: repositry,
                                          uiModelMapper: uiModel)
            let presenter = HomePresenter(view: homeViewController,
                                          useCase: useCase)
            homeViewController.presenter = presenter
            return homeViewController

        case .cart:
            let remoteDataStore = CartRemoteDataStore()
            let localDataStore = LocalDataStore()
            let uiModel = UIModelMapper()
            let repositry = CartRepositry(remoteDataStore: remoteDataStore,
                                          localDataStore: localDataStore)
            let useCase = CartUseCase(repositry: repositry,
                                      uiModelMapper: uiModel)
            let cartViewController = CartViewController()
            let presenter = CartPresenter(view: cartViewController,
                                          useCase: useCase)
            cartViewController.presenter = presenter
            return cartViewController

        case .tabbarController:
            return TabBarController()
        }
    }
}
