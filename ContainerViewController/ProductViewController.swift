//
//  ProductViewController.swift
//  ContainerViewController
//
//  Created by Satyadev Chauhan on 07/01/20.
//  Copyright © 2020 Satyadev Chauhan. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    var product: Product?
    
    convenience init(product: Product) {
        self.init()
        self.product = product
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let prod = product {
            updateData(prod)
        }
    }

    fileprivate func updateData(_ product: Product) {
        
        nameLabel.text = product.name
        priceLabel.text = String(product.price)
        locationLabel.text = product.location
    }
}
