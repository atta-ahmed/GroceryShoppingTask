//
//  HomePresnter.swift
//  GroceryShoppingTask
//
//  Created by Atta Amed on 7/9/20.
//  Copyright © 2020 Atta Amed. All rights reserved.
//

import Foundation
//MARK:- Protocol
protocol HomePresenterProtocol {
    var numberOfProducts: Int {get}
    func fetchHomeProducts()
    func fetchLocalCart()
    func product(at index: Int) -> ProductUIModel
    func didSelectProduct(at index: Int)
}

class HomePresenter {

    //MARK:- properties
    var offset = 0
    var products: [ProductUIModel] = []
    let useCase: ProductsUseCase

    public weak var view: HomeViewProtocol?

    //MARK:- init
    public init(view: HomeViewProtocol,
                useCase: ProductsUseCase) {
        self.view = view
        self.useCase = useCase
    }
}

//MARK:- Handle UI Logic
extension HomePresenter: HomePresenterProtocol {
    var numberOfProducts: Int {
        return products.count
    }

    /// fetch only local data to update quantity
    func fetchLocalCart() {
        useCase.fetchLocalCart(currentProduct: products) { (error, products) in
            self.products = products
            self.view?.reloadProductsList()
        }
    }

    /// Get products from api and merge with offline cart to update quantity
    func fetchHomeProducts() {
        view?.showIndecator()
        useCase.featchData(offset: offset) { (error, products) in
            self.products += products
            self.offset = self.products.count
            self.view?.stopIndicator()
            self.view?.reloadProductsList()
        }
    }
    /// Whene Add product to cart
    func updateLocalCart(model: ProductUIModel) {
        useCase.updateLocalCart(model) {
            self.view?.reloadProductsList()
        }
    }

    func product(at index: Int) -> ProductUIModel {
        return products[index]
    }
    /// When tab on Product
    func didSelectProduct(at index: Int){
        products[index].quantity += 1
        updateLocalCart(model: products[index])
    }
}
