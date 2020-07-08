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
    fileprivate var presenter = ShoppingPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollection()
        presenter.shoppingDelegate = self
        presenter.getProducts()
    }

    func setupCollection() {
        self.shoppingCollectionView.register(UINib(nibName: "ShoppingCell", bundle: nil),
                                             forCellWithReuseIdentifier: "ShoppingCell")
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
        return presenter.products.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShoppingCell",
                                                         for: indexPath) as? ShoppingCell {
            cell.setup(product: presenter.products[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }


}

extension ShoppingViewController: ShoppingPresenterProtocol {
    func onSuccessGetProducts() {
        shoppingCollectionView.reloadData()
    }
}

extension ShoppingViewController: UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        loadMoreCharacters(scrollView)
    }

    fileprivate func loadMoreCharacters(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height -
            scrollView.frame.size.height

        if maximumOffset - currentOffset <= 20.0 {
            DispatchQueue.main.async {
                self.presenter.getProducts()
            }
        }
    }
}
