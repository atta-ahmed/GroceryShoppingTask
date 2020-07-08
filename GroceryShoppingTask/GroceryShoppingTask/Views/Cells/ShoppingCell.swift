//
//  ShoppingCell.swift
//  GroceryShoppingTask
//
//  Created by Atta Amed on 7/7/20.
//  Copyright © 2020 Atta Amed. All rights reserved.
//

import UIKit

class ShoppingCell: UICollectionViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setup(product: Product) {
        imageView.downloadImageByKF(imagePath: product.imageURL ?? "")
        title.text = "\(product.name ?? "") - $\(product.pricePerUnit ?? 0)"
    }


}
