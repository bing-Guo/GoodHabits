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

class CreateHabitViewController: UIViewController {
    
    var mainView: CreateHabitView { return self.view as! CreateHabitView }
    override func loadView() { self.view = CreateHabitView() }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
