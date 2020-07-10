//
//  CartsViewController.swift
//  GroceryShoppingTask
//
//  Created by Atta Amed on 7/9/20.
//  Copyright © 2020 Atta Amed. All rights reserved.
//

import UIKit
protocol CartViewProtocol: AnyObject {
    func showIndecator()
    func reloadCartList()
    func cartUpdated()
}


class CartViewController: UIViewController {
    
    @IBOutlet weak var cartTableView: UITableView!
    lazy var boxView: UIView! = { return self.newLoadingIndicator() }()
    var presenter: CartPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCartTable()
    }
    override func viewWillAppear(_ animated: Bool) {
        presenter?.fetchLocalCart()
    }
    
    private func setUpCartTable() {
        cartTableView.register(UINib(nibName: "CartCell", bundle: nil),
                               forCellReuseIdentifier: "CartCell")
        cartTableView.tableFooterView = UIView()
        cartTableView.delegate = self
        cartTableView.dataSource = self
        cartTableView.rowHeight = 80
        cartTableView.separatorInset.left = 0
    }
}

extension CartViewController: CartViewProtocol {
    func showIndecator() {
        //
    }

    func reloadCartList() {
        cartTableView.reloadData()
    }

    func cartUpdated() {
        //
    }

}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfCart ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell =  cartTableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as? CartCell {
            if let cart = self.presenter?.cart(at: indexPath.row) {
                cell.configeur(cart: cart)
                cell.plusButton.addTarget(self,action: #selector(increaseQuantity),
                                          for: .touchUpInside)

                cell.minusButton.addTarget(self,action: #selector(decreseQuantity),
                                          for: .touchUpInside)
                return cell
            }
        }
        return UITableViewCell()
    }

    @objc func increaseQuantity(_ sender: UIButton) {
        presenter?.didChangeQuantity(whereID: sender.tag, isIncrease: true)
    }

    @objc func decreseQuantity(_ sender: UIButton) {
        presenter?.didChangeQuantity(whereID: sender.tag, isIncrease: false)
    }
}
