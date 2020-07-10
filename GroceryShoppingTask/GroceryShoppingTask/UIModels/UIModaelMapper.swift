//
//  UIModaelMapper.swift
//  GroceryShoppingTask
//
//  Created by Atta Amed on 7/10/20.
//  Copyright © 2020 Atta Amed. All rights reserved.
//

import Foundation

protocol UIModelMapperProtocol {
    func convertProductToUIModel(products: [Product]) -> [ProductUIModel]
    func convertCartToProductUIModel(cart: [Cart]) -> [ProductUIModel]
    func convertProductUIModelToCart(model: ProductUIModel) -> Cart
    func updateQuantityOfProducts(localPoducts: [ProductUIModel],
                                  remoteProducts:  [ProductUIModel]) -> [ProductUIModel]
}

struct UIModelMapper: UIModelMapperProtocol {

    func convertProductToUIModel(products: [Product]) -> [ProductUIModel] {
        return products.map {
            return ProductUIModel(id: $0.id,
                                  imageURL: $0.imageURL,
                                  name: $0.name,
                                  pricePerUnit: $0.pricePerUnit)
        }
    }

    func convertCartToCartUIModel(cart: [Cart]) -> [CartUiModel] {
        return cart.map {
            return CartUiModel(id: $0.products.first?.product?.id,
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
        return Cart(id: "db08520c-c151-11ea-b3de-0242ac130004", products: [newProduct])
    }

    func updateQuantityOfProducts(localPoducts: [ProductUIModel], remoteProducts:  [ProductUIModel]) -> [ProductUIModel] {
        var updatedProducts = remoteProducts
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

}
