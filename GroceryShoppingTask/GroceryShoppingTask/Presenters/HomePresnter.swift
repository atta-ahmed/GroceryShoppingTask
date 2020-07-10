//
//  HomePresnter.swift
//  GroceryShoppingTask
//
//  Created by Atta Amed on 7/9/20.
//  Copyright © 2020 Atta Amed. All rights reserved.
//

import Foundation

protocol HomePresenterProtocol {

    var numberOfProducts: Int {get}
    func fetchHomeProducts()
    func fetchLocalCart()
    func product(at index: Int) -> ProductUIModel
    func didSelectProduct(at index: Int)
}

class HomePresenter {

    var offset = 0
    var products: [ProductUIModel] = []
    let useCase: ProductsUseCase
    public weak var view: HomeViewProtocol?

    public init(view: HomeViewProtocol,
                useCase: ProductsUseCase) {
        self.view = view
        self.useCase = useCase
    }
}

extension HomePresenter: HomePresenterProtocol {
    var numberOfProducts: Int {
        return products.count
    }

    func fetchLocalCart() {
        useCase.fetchLocalCart(currentProduct: products) { (error, products) in
            self.products = products
            self.view?.reloadProductsList()
        }
    }

    func fetchHomeProducts() {
        view?.showIndecator()
        useCase.featchData(offset: offset) { (error, products) in
            self.products += products
            self.offset = self.products.count
            self.view?.reloadProductsList()
        }
    }

    func updateLocalCart(model: ProductUIModel) {
        useCase.updateLocalCart(model) {
            self.view?.reloadProductsList()
        }
    }

    func product(at index: Int) -> ProductUIModel {
        return products[index]
    }
    func didSelectProduct(at index: Int){
        products[index].quantity += 1
        updateLocalCart(model: products[index])
    }
}
