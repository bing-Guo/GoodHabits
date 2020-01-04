//
//  CreateHabitViewController.swift
//  GoodHabits
//
//  Created by Bing Guo on 2020/1/1.
//  Copyright © 2020 Bing Guo. All rights reserved.
//

import UIKit
import FlexLayout
import PinLayout

class CreateHabitViewController: UIViewController, CreateHabitDelegate {
    
    var mainView: CreateHabitView { return self.view as! CreateHabitView }
    override func loadView() { self.view = CreateHabitView() }

    override func viewDidLoad() {
        super.viewDidLoad()
        settingNavigationBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
//        let allTextField = self.view.subviews.getN
    }
    
    func settingNavigationBar() {
        let rightButton = UIBarButtonItem(
            title: "儲存",
            style: .plain,
            target: self,
            action: #selector(save)
        )
        navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc func save() {
        
    }
}
