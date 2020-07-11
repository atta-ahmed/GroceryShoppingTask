//
//  CartsViewController.swift
//  GroceryShoppingTask
//
//  Created by Atta Amed on 7/9/20.
//  Copyright © 2020 Atta Amed. All rights reserved.
//

import UIKit
//MARK:- protocol
protocol CartViewProtocol: AnyObject, BadgeNumberProvider {
    func showIndecator()
    func stopIndicator()
    func reloadCartList()
    func gotoPurchase()
}


class CartViewController: UIViewController, BadgeUpdatable {
    
    //MARK:- outlets
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var purchaseButton: UIButton!

    //MARK:- properties
    lazy var boxView: UIView! = { return self.view.newLoadingIndicator() }()
    var presenter: CartPresenterProtocol?

    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCartTable()
    }
    override func viewWillAppear(_ animated: Bool) {
        presenter?.fetchLocalCart()
    }

    @IBAction func purchase(_ sender: UIButton) {
        presenter?.updateCart()
    }
    //MARK:- Setup UI
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

//MARK:- Handle ui
extension CartViewController: CartViewProtocol {

    func showIndecator() {
        self.view.showLoadingIndicator(boxView)
    }
    func stopIndicator(){
        self.view.hideLoadingIndicator(boxView)
    }

    func reloadCartList() {
        cartTableView.reloadData()
    }
    func gotoPurchase() {
        print("")
    }
}

//MARK:- tableview
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
