//
//  Extensions.swift
//  GroceryShoppingTask
//
//  Created by Atta Amed on 7/8/20.
//  Copyright © 2020 Atta Amed. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {

    func downloadImageByKF(imagePath: String?){
        if let path = imagePath {
            self.kf.setImage(with:  URL(string: path ) , placeholder: UIImage(named: "default"), options: [], progressBlock: nil, completionHandler: nil)
        }
    }
    
    func downloadImageFrom(link: String, contentMode: UIView.ContentMode) {
        if let url = URL(string: link) {
            URLSession.shared.downloadTask(with: url ) { (data, responce, error) in
                DispatchQueue.main.async {
                    self.contentMode =  contentMode
                    let data = try? Data(contentsOf: data!)
                    if let imageData = data {
                        self.image = UIImage(data: imageData)
                    }
                }
                }.resume()
        }
    }

}
