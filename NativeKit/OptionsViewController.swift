//
//  OptionsViewController.swift
//  NativeKit
//
//  Created by Zhilei Zheng on 5/3/19.
//  Copyright © 2019 Zhilei Zheng. All rights reserved.
//

import UIKit

class OptionsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.green
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "Options"
    }
    
}
