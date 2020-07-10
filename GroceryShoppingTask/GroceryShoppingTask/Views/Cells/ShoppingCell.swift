//
//  ShoppingCell.swift
//  GroceryShoppingTask
//
//  Created by Atta Amed on 7/7/20.
//  Copyright © 2020 Atta Amed. All rights reserved.
//

import UIKit

class ShoppingCell: UICollectionViewCell {

    @IBOutlet weak var quintityLabel: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    /// Configuer cell with UIModel
    func configuer(product: ProductUIModel) {
        imageView.downloadImageByKF(imagePath: product.imageURL ?? "")
        title.text = "\(product.name ?? "") - $\(product.pricePerUnit ?? 0)"
        if product.quantity == 0 {
            quintityLabel.isHidden =  true
        } else {
            quintityLabel.text = "\(product.quantity)"
            quintityLabel.isHidden = false
        }
    }


}
