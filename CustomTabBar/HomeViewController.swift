//
//  HomeViewController.swift
//  CustomTabBar
//
//  Created by 🅐🅝🅐🅢 on 15/05/18.
//  Copyright © 2018 nfnlabs. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    //MARK: - Actions
    @IBAction func btnCloseOnClick(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
