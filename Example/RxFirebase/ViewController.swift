//
//  ViewController.swift
//  RxFirebase
//
//  Created by iKichiemon on 01/16/2018.
//  Copyright (c) 2018 iKichiemon. All rights reserved.
//

import UIKit
import RxFirebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        let t = Test.init(a: "a")
        print(t)
    }

}

