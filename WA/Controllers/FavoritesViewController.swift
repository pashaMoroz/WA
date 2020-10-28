//
//  FavoritesViewController.swift
//  WA
//
//  Created by Pavel Moroz on 27.10.2020.
//

import UIKit


class FavoritesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        self.navigationItem.title = "Избранные города"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}
