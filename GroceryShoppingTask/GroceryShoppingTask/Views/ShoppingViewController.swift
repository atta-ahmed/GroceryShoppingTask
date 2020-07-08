//
//  ShoppingViewController.swift
//  GroceryShoppingTask
//
//  Created by Atta Amed on 7/7/20.
//  Copyright © 2020 Atta Amed. All rights reserved.
//

import UIKit

class ShoppingViewController: UIViewController {

    @IBOutlet weak var shoppingCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollection()
    }

    func setupCollection() {
        self.shoppingCollectionView.register(UINib(nibName: "ShoppingCell", bundle: nil), forCellWithReuseIdentifier: "ShoppingCell")
        shoppingCollectionView.delegate = self
        shoppingCollectionView.dataSource = self
        layoutCells()
    }

    private func layoutCells() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10)
        layout.minimumInteritemSpacing = 10.0
        layout.minimumLineSpacing = 10.0
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.size.width - 30)/2, height: ((UIScreen.main.bounds.size.width - 30)/2))
        shoppingCollectionView.collectionViewLayout = layout
    }
}

extension ShoppingViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShoppingCell",
                                                         for: indexPath) as? ShoppingCell {
            cell.setup()
            return cell
        }
        return UICollectionViewCell()
    }


}
