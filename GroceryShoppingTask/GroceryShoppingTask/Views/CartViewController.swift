//
//  CartViewController.swift
//  GroceryShoppingTask
//
//  Created by Atta Amed on 7/7/20.
//  Copyright © 2020 Atta Amed. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {

    @IBOutlet weak var cartTableView: UITableView!
    var presenter = CartPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCartTable()
        presenter.getCarts()
    }

    private func setUpCartTable() {
        cartTableView.register(UINib(nibName: "CartCell", bundle: nil),
                               forCellReuseIdentifier: "CartCell")
        cartTableView.delegate = self
        cartTableView.dataSource = self
        cartTableView.rowHeight = 80
        cartTableView.separatorInset.left = 0
    }

}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell =  cartTableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as? CartCell {
            cell.Config()
            return cell
        }
        return UITableViewCell()
    }

}
