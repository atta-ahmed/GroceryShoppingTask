//
//  UIModaelMapper.swift
//  GroceryShoppingTask
//
//  Created by Atta Amed on 7/10/20.
//  Copyright © 2020 Atta Amed. All rights reserved.
//

import Foundation
// MARK: - UIModelProtocol
protocol UIModelMapperProtocol {
    func convertProductToUIModel(products: [Product]) -> [ProductUIModel]
    func convertCartToProductUIModel(cart: [Cart]) -> [ProductUIModel]
    func convertProductUIModelToCart(model: ProductUIModel) -> Cart
    func updateQuantityOfProducts(localPoducts: [ProductUIModel],
                                  remoteProducts:  [ProductUIModel]) -> [ProductUIModel]
}

// MARK: - UIModelMapper
// Todo:- seperate logic

struct UIModelMapper: UIModelMapperProtocol {

    func convertProductToUIModel(products: [Product]) -> [ProductUIModel] {
        return products.map {
            return ProductUIModel(id: $0.id,
                                  imageURL: $0.imageURL,
                                  name: $0.name,
                                  pricePerUnit: $0.pricePerUnit)
        }
    }

    func convertCartToCartUIModel(cart: [Cart]) -> [ProductUIModel] {
        return cart.map {
            return ProductUIModel(id: $0.products.first?.product?.id,
                                  imageURL: $0.products.first?.product?.imageURL,
                                  name: $0.products.first?.product?.name,
                                  pricePerUnit: $0.products.first?.product?.pricePerUnit,
                                  quantity: $0.products.first?.quantity ?? 0)
        }
    }

    func convertCartToProductUIModel(cart: [Cart]) -> [ProductUIModel] {
        return cart.map{
            return ProductUIModel(id: $0.products.first?.product?.id,
                                  imageURL: $0.products.first?.product?.imageURL,
                                  name: $0.products.first?.product?.name,
                                  pricePerUnit: $0.products.first?.product?.pricePerUnit,
                                  quantity: $0.products.first?.quantity ?? 0)
        }
    }

    func convertProductUIModelToCart(model: ProductUIModel) -> Cart {
        let product = Product(id: model.id, imageURL: model.imageURL, name: model.name, pricePerUnit: model.pricePerUnit)
        let newProduct = ProductElement(quantity: model.quantity, product: product)
        return Cart(id: GroceryAPIConfig.id, products: [newProduct])
    }

    func updateQuantityOfProducts(localPoducts: [ProductUIModel], remoteProducts:  [ProductUIModel]) -> [ProductUIModel] {
        var updatedProducts = remoteProducts
        for (i,_) in remoteProducts.enumerated() {
            updatedProducts[i].quantity = 0
        }
        for localProduct in localPoducts {
            for (index, product) in updatedProducts.enumerated() {
                if product.id == localProduct.id {
                    updatedProducts[index].quantity = localProduct.quantity
                    break
                }
            }
        }
        return updatedProducts
    }

    func convertProductUIModelToCartApiModel(products: [ProductUIModel]) -> CartApiModel {
        var productsForApi: [ProductApiModel] = []
        _ = products.map {
            let element = ProductModel(id: $0.id ?? 0)
            let productApi = ProductApiModel(quantity: $0.quantity, product: element)
            productsForApi.append(productApi)
        }
        return CartApiModel(id: GroceryAPIConfig.id,
                            products: productsForApi)
    }
    func convertProductUIModelToCartParamters(products: [ProductUIModel]) -> [String: Any] {
        var  paramters = ["id": GroceryAPIConfig.id, "products": []] as [String: Any]
        _ = products.map {
            let product = ["id":$0.id ?? 0] as [String: Any]
            let products = ["quantity": $0.quantity, "product": product] as [String : Any]
            paramters.updateValue(products, forKey: "products")
        }
        return paramters
    }

}
