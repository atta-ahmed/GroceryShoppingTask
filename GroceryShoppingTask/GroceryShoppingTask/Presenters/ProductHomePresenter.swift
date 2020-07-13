//
//  ProductHomePresenter.swift
//  GroceryShoppingTask
//
//  Created by Atta Amed on 7/9/20.
//  Copyright © 2020 Atta Amed. All rights reserved.
//

import Foundation
//MARK:- Protocol
protocol ProductHomePresenterProtocol: BadgeNumberManager {
    var numberOfProducts: Int {get}
    func fetchHomeProducts()
    func fetchLocalCart()
    func product(at index: Int) -> ProductUIModel
    func didSelectProduct(at index: Int)
}

class ProductHomePresenter {

    //MARK:- properties
    var offset = 0
    var products: [ProductUIModel] = []
    let useCase: ProductsUseCaseProtocol
    var totalQuantity: String {
        let count = products.reduce(0) { $0 + $1.quantity }
        return  count > 0 ? "\(count)" : ""
    }

    public weak var view: ProductHomeViewProtocol?

    //MARK:- init
    public init(view: ProductHomeViewProtocol,
                useCase: ProductsUseCaseProtocol) {
        self.view = view
        self.useCase = useCase
    }
}

//MARK:- Handle UI Logic
extension ProductHomePresenter: ProductHomePresenterProtocol {
    var numberOfProducts: Int {
        return products.count
    }

    /// fetch only local data to update quantity
    func fetchLocalCart() {
        useCase.fetchLocalCart(currentProduct: products) { [weak self] (error, products) in
            guard let self = self else { return }
            self.products = products
            self.view?.reloadProductsList()
            self.updateBadgeNumber(in: self.view, number: self.totalQuantity)
        }
    }

    /// Get products from api and merge with offline cart to update quantity
    func fetchHomeProducts() {
        view?.showIndecator()
        useCase.featchData(offset: offset) { [weak self] (error, products) in
            guard let self = self else { return }
            self.products += products
            self.offset = self.products.count
            self.view?.stopIndicator()
            self.view?.reloadProductsList()
            self.updateBadgeNumber(in: self.view, number: self.totalQuantity)
        }
    }
    /// Whene Add product to cart
    func updateLocalCart(model: ProductUIModel) {
        useCase.updateLocalCart(model) { [weak self] in
            guard let self = self else { return }
            self.view?.reloadProductsList()
            self.updateBadgeNumber(in: self.view, number: self.totalQuantity)
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
