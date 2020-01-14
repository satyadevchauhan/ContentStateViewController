//
//  ErrorViewController.swift
//  ContainerViewController
//
//  Created by Satyadev Chauhan on 07/01/20.
//  Copyright © 2020 Satyadev Chauhan. All rights reserved.
//

import UIKit

class ErrorViewController: UIViewController {

    @IBOutlet weak var errorTitleLabel: UILabel!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    var error: Error?
    
    convenience init(error: Error) {
        self.init()
        self.error = error
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        errorTitleLabel.text = "Error"
        errorMessageLabel.text = error?.localizedDescription
    }
    
}
