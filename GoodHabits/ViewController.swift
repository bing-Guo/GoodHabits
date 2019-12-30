//
//  ViewController.swift
//  GoodHabits
//
//  Created by Bing Guo on 2019/12/30.
//  Copyright © 2019 Bing Guo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.title = "習慣"
        
        let rightButton = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(setting)
        )
        
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc func setting() {
        print("event")
    }
}

