//
//  CartCell.swift
//  GroceryShoppingTask
//
//  Created by Atta Amed on 7/8/20.
//  Copyright © 2020 Atta Amed. All rights reserved.
//

import UIKit
import Kingfisher

class CartCell: UITableViewCell {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    /// Configuer cell with UIModel
    func configeur(cart: ProductUIModel) {
        
        priceLabel.text = "$\(cart.pricePerUnit ?? 0.0)"
        titleLabel.text = cart.name
        countLabel.text = "\(cart.quantity)"
        productImageView.downloadImageByKF(imagePath: cart.imageURL ?? "")

        /// set buttons tag by ids to be knowen whic cart entity take action
        minusButton.tag = cart.id ?? 0
        plusButton.tag = cart.id ?? 0
    }
    
}
