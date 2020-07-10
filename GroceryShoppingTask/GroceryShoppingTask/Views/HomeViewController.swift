//
//  HomeViewController.swift
//  GroceryShoppingTask
//
//  Created by Atta Amed on 7/9/20.
//  Copyright © 2020 Atta Amed. All rights reserved.
//

import UIKit

protocol HomeViewProtocol: AnyObject {
    func showIndecator()
    func reloadProductsList()
    func cartUpdated()
}

class HomeViewController: UIViewController {

    @IBOutlet weak var shoppingCollectionView: UICollectionView!
    lazy var boxView: UIView! = { return self.newLoadingIndicator() }()
    var presenter: HomePresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollection()
        presenter?.fetchHomeProducts()
    }
    override func viewWillAppear(_ animated: Bool) {
        presenter?.fetchLocalCart()
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

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfProducts ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShoppingCell",
                                                         for: indexPath) as? ShoppingCell,
            let product = presenter?.product(at: indexPath.row) {
            cell.configuer(product: product )
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectProduct(at: indexPath.row)
    }

}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        loadMoreCharacters(scrollView)
    }

    fileprivate func loadMoreCharacters(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height -
            scrollView.frame.size.height

        if maximumOffset - currentOffset <= 20.0 {
            DispatchQueue.main.async {
                self.presenter?.fetchHomeProducts()
            }
        }
    }
}

extension HomeViewController: HomeViewProtocol {

    func cartUpdated() {
        shoppingCollectionView.reloadData()
    }

    func showIndecator() {
        //  self.showLoadingIndecator(boxView)
    }

    func reloadProductsList() {
        shoppingCollectionView.reloadData()
//        if let cartVC = self.tabBarController?.viewControllers?[1] as? CartsViewController {
//            cartVC.tabBarController?.tabBarItem.badgeValue =
//        }
    }
}
