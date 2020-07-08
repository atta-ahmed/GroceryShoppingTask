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
    func setup() {
        if let image = UIImage(named: "default") {
            self.imageView.image = image
        }
        title.text = "fdfdffdgdfdfggd"
    }


}
