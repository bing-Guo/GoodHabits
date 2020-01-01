//
//  ViewController.swift
//  GoodHabits
//
//  Created by Bing Guo on 2019/12/30.
//  Copyright © 2019 Bing Guo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var habitsTableView = UITableView()
    var testTableData = ["Beach", "Clubs", "Chill", "Dance"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingNavigationBar()
        
        habitsTableView = UITableView(frame: self.view.bounds, style: .plain)
        habitsTableView.delegate = self
        habitsTableView.dataSource = self
        habitsTableView.backgroundColor = .white
        
        habitsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "habitsCell")
        view.addSubview(habitsTableView)
    }
    
    @objc func passToCreateHabitView() {
        self.navigationController?.pushViewController(CreateHabitViewController(), animated: true)
    }
    
    func settingNavigationBar() {
        self.view.backgroundColor = .white
        self.title = "習慣"
        
        let rightButton = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(passToCreateHabitView)
        )
        
        self.navigationItem.rightBarButtonItem = rightButton
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.testTableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "habitsCell", for: indexPath)
        let habitText = self.testTableData[indexPath.row]
        let habitEmoji = "🥰"
        cell.textLabel?.text = "\(habitEmoji) \t \(habitText)"
        
        cell.textLabel?.font = UIFont(name: "Arial", size: 24)
        
        return cell
    }
}
