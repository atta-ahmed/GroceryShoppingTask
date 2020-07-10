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
    func stopIndicator()
    func reloadProductsList()
    func cartUpdated()
}

//MARK:- Setup View
class HomeViewController: UIViewController {

    //MARK:- outlets
    @IBOutlet weak var shoppingCollectionView: UICollectionView!
    //MARK:- properties
    lazy var boxView: UIView! = { return self.view.newLoadingIndicator() }()
    var presenter: HomePresenterProtocol?

    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollection()
        presenter?.fetchHomeProducts()
    }
    override func viewWillAppear(_ animated: Bool) {
        presenter?.fetchLocalCart()
    }

    //MARK:- Setup UI
    func setupCollection() {
        self.shoppingCollectionView.register(UINib(nibName: "ShoppingCell", bundle: nil),
                                             forCellWithReuseIdentifier: "ShoppingCell")
        shoppingCollectionView.delegate = self
        shoppingCollectionView.dataSource = self
        layoutCells()
    }
    /// UICollectionView Flow Layout
    private func layoutCells() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10)
        layout.minimumInteritemSpacing = 10.0
        layout.minimumLineSpacing = 10.0
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.size.width - 30)/2, height: ((UIScreen.main.bounds.size.width - 30)/2))
        shoppingCollectionView.collectionViewLayout = layout
    }
}

//MARK:- Handle Collection
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

//MARK:- Handle pagenation
extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        loadMoreProducts(scrollView)
    }

    /// whene scroll to the bottom of view it's call api
    fileprivate func loadMoreProducts(_ scrollView: UIScrollView) {
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

//MARK:- Handle UI
extension HomeViewController: HomeViewProtocol {
    /// whene add product to cart
    func cartUpdated() {
        shoppingCollectionView.reloadData()
    }

    func showIndecator() {
        self.view.showLoadingIndicator(boxView)
    }
    func stopIndicator(){
        self.view.hideLoadingIndicator(boxView)
    }
    func reloadProductsList() {
        shoppingCollectionView.reloadData()
    }
}
