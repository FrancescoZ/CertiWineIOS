//
//  ViewController.swift
//  CertiWine
//
//  Created by Francesco Zanoli on 03/03/2018.
//  Copyright © 2018 CertiWine. All rights reserved.
//

import UIKit

class LViewController: UIViewController {

    lazy var loginCoordinator = LoginCoordinator(rootViewController: self)
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loginCoordinator.start()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

