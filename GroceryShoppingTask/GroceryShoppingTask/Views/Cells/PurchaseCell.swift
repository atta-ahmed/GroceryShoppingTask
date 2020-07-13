//
//  PurchaseCell.swift
//  GroceryShoppingTask
//
//  Created by Atta Amed on 7/13/20.
//  Copyright © 2020 Atta Amed. All rights reserved.
//

import UIKit

class PurchaseCell: UITableViewCell {


    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var countLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    /// Configuer cell with UIModel
    func configeur(cart: ProductUIModel) {

        priceLabel.text = "$\(cart.pricePerUnit ?? 0.0)"
        titleLabel.text = cart.name
        countLabel.text = "\(cart.quantity)"
        productImageView.downloadImageByKF(imagePath: cart.imageURL ?? "")
    }
    
}
