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

extension Encodable {

  var dictionary: [String: Any]? {
    guard let data = try? JSONEncoder().encode(self) else { return nil }
    return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
  }

}

extension UIViewController {

    // Loading Indicator Factory
    func newLoadingIndicator() -> UIView {
        // Box Configuration
        let box = UIView(frame: CGRect(x: self.view.frame.width/2.0 - 30,
                                       y: self.view.frame.height/2.0 - 30,
                                       width: 60,
                                       height: 60))
        box.backgroundColor = UIColor(white: 0.0, alpha: 0.2)
        box.alpha = 1.0
        box.layer.cornerRadius = 10

        // Spinner configuration
        let activityView = UIActivityIndicatorView(style: .large)
        activityView.frame = CGRect(x: 10, y: 10, width: 40, height: 40)
        activityView.startAnimating()

        // Add the spinner to the box:
        box.addSubview(activityView)
        return box
    }

    func showLoadingIndicator(_ indicator: UIView) {
        self.view.addSubview(indicator)
        self.view.isUserInteractionEnabled = false
    }

    func hideLoadingIndicator(_ indicator: UIView) {
        indicator.removeFromSuperview()
        self.view.isUserInteractionEnabled = true
    }
}


extension UserDefaults {

    func cartExists(id: Int, key: String) -> Bool {
        if let object = decode(for: [Cart].self, using: key) {
        let cart = object as [Cart]
            return cart.filter{$0.products[0].product?.id == id}.count > 0
        }
        return false
    }

    func encode<T : Codable>(for type : T, using key : String) {
        let defaults = UserDefaults.standard
        let encodedData = try? PropertyListEncoder().encode(type)
        defaults.set(encodedData, forKey: key)
        defaults.synchronize()
    }

    func decode<T : Codable>(for type : T.Type, using key : String) -> T? {
        let defaults = UserDefaults.standard
        guard let data = defaults.object(forKey: key) as? Data else {return nil}
        let decodedObject = try? PropertyListDecoder().decode(type, from: data)
        return decodedObject
    }


}
