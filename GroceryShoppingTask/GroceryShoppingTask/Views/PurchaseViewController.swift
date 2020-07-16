//
//  PurchaseViewController.swift
//  GroceryShoppingTask
//
//  Created by Atta Amed on 7/13/20.
//  Copyright © 2020 Atta Amed. All rights reserved.
//

import UIKit

protocol PurchaseViewProtocol: AnyObject, Routable {
    func showIndecator()
    func stopIndicator()
    func reloadCartList()
    func goToPay()
}

class PurchaseViewController: UIViewController {

    @IBOutlet weak var purchaseTableView: UITableView!
    @IBOutlet weak var goToPayButton: UIButton!

    //MARK:- properties
    lazy var boxView: UIView! = { return self.view.newLoadingIndicator() }()
    var presenter: PurchasePresenterProtocol?

    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCartTable()
    }
    override func viewWillAppear(_ animated: Bool) {
//        presenter?.notfiyByCart()
    }

    @IBAction func pay(_ sender: UIButton) {
//        presenter?
    }
    //MARK:- Setup UI
    private func setUpCartTable() {
        purchaseTableView.register(UINib(nibName: "PurchaseCell", bundle: nil),
                                   forCellReuseIdentifier: "PurchaseCell")
        purchaseTableView.tableFooterView = UIView()
        purchaseTableView.delegate = self
        purchaseTableView.dataSource = self
        purchaseTableView.rowHeight = 70
        purchaseTableView.separatorInset.left = 0
    }

}
//MARK:- tableview
extension PurchaseViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0 //presenter?.numberOfCart ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell =  purchaseTableView.dequeueReusableCell(withIdentifier: "PurchaseCell", for: indexPath) as? CartCell {
            return cell
        }
        return UITableViewCell()
    }
}

extension PurchaseViewController: PurchaseViewProtocol {
    func showIndecator() {
        //
    }

    func stopIndicator() {
        //
    }

    func reloadCartList() {
        //
    }

    func goToPay() {
        //
    }

}
