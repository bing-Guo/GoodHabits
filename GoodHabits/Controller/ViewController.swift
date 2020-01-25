import UIKit
import RealmSwift

struct TodayHabit {
    var id = ""
    var title = ""
    var icon = ""
    var checked: Bool = false
}

class ViewController: UIViewController {
    
    var habitsTableView = UITableView()
    let greenColorHex = "#5CB85C"
    
    var todayHabits: [TodayHabit] {
        let realm = try! Realm()
        print("fileURL: \(realm.configuration.fileURL!)")
        let nowDateString = self.getNowDate()
        
        var habitStatus: [HabitStatus] {
            return Array(realm.objects(HabitStatus.self).filter("date = '\(nowDateString)'"))
        }
        
        var habitsData: [Habit] {
            return Array(realm.objects(Habit.self))
        }
        
        var todayHabit: [TodayHabit] = []
        
        for habit in habitsData {
            var temp: TodayHabit
            
            var existed = false
            for status in habitStatus{
                if status.id == habit.id {
                    existed = true
                }
            }
            
            temp = TodayHabit(id: habit.id, title: habit.title, icon: habit.icon, checked: existed)
            
            todayHabit.append(temp)
        }
        
        return todayHabit
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingNavigationBar()
        
        habitsTableView = UITableView(frame: self.view.bounds, style: .plain)
        habitsTableView.delegate = self
        habitsTableView.dataSource = self
        habitsTableView.backgroundColor = UIColor(hex: "#333333")
        habitsTableView.separatorStyle = .none
        
        habitsTableView.register(HabitTableViewCell.self, forCellReuseIdentifier: "habitsCell")
        view.addSubview(habitsTableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        print("reload")
        self.habitsTableView.reloadData()
    }
    
    func settingNavigationBar() {
        navigationItem.title = "習慣"
        
        let attributes: NSDictionary = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 28)
        ]
        
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.barTintColor = .white
        
        self.navigationController?.navigationBar.titleTextAttributes = attributes as? [NSAttributedString.Key : Any]
        
        // Background Transparent
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(passToCreateHabitView)
        )
    }
    
    @objc func passToCreateHabitView() {
        self.navigationController?.pushViewController(CreateHabitViewController(), animated: true)
    }
    @objc func addBtnAction() {  print("addBtnAction")  }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todayHabits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "habitsCell", for: indexPath) as! HabitTableViewCell
        
        let habit = self.todayHabits[indexPath.row]
        let habitText = habit.title
        let habitEmoji = habit.icon
        
        cell.iconLabel.text = "\(habitEmoji)"
        cell.titleLabel.text = "\(habitText)"
        
        cell.isCheck(habit.checked)
        
        return cell
    }
    
    func checkAction(cell: HabitTableViewCell, chioseHabit: TodayHabit) {
        
        let nowDateString = self.getNowDate()
        
        let habitStatus: HabitStatus = HabitStatus(id: chioseHabit.id, date: nowDateString)
        self.appendHabitStatusToRealm(habitStatus: habitStatus)
        
        cell.isCheck(true)
    }
    
    func uncheckAction(cell: HabitTableViewCell, chioseHabit: TodayHabit) {
        
        let nowDateString = self.getNowDate()
        
        self.deleteHabitStatusInRealm(habitID: chioseHabit.id, date: nowDateString)
        
        cell.isCheck(false)
    }
    
    func deleteAction(indexPath: IndexPath) {
        let chioseHabit = self.todayHabits[indexPath.row]
        
        self.deleteHabitInRealm(habitID: chioseHabit.id)
        self.habitsTableView.beginUpdates()
        self.habitsTableView.deleteRows(at: [indexPath], with: .fade)
        self.habitsTableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let configuration = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { actions -> UIMenu? in
            
            let cell = tableView.cellForRow(at: indexPath) as! HabitTableViewCell
            let chioseHabit = self.todayHabits[indexPath.row]
            
            let check = UIAction(title: "Check", image: UIImage(systemName: "checkmark.circle"), identifier: nil) { action in
                self.checkAction(cell: cell, chioseHabit: chioseHabit)
            }
            let uncheck = UIAction(title: "Uncheck", image: UIImage(systemName: "arrowshape.turn.up.left.circle"), identifier: nil) { action in
                self.uncheckAction(cell: cell, chioseHabit: chioseHabit)
            }
            
            let delete = UIAction(title: "Confirm Delete", image: UIImage(systemName: "trash.fill"), identifier: nil) { action in
                self.deleteAction(indexPath: indexPath)
            }
            
            let doubleCheckDelete = UIMenu(__title: "Delete", image: nil, identifier: nil, children:[delete])
            
            
            if(chioseHabit.checked) {
                return UIMenu(__title: "Menu", image: nil, identifier: nil, children:[uncheck, doubleCheckDelete])
            }
            
            return UIMenu(__title: "Menu", image: nil, identifier: nil, children:[check, doubleCheckDelete])
        }
        return configuration
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(90)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // pass to calendar
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CalendarViewController()
        vc.habitID = todayHabits[indexPath.row].id
        vc.habitTitle = todayHabits[indexPath.row].title
        vc.habitIcon = todayHabits[indexPath.row].icon
//        self.navigationController?.pushViewController(vc, animated: true)
        self.present(vc, animated: true, completion: nil)
    
    }
    
    fileprivate func appendHabitStatusToRealm(habitStatus: HabitStatus) {
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(habitStatus)
        }
    }
    
    fileprivate func deleteHabitStatusInRealm(habitID: String, date: String) {
        let realm = try! Realm()
        let habitStatus = realm.objects(HabitStatus.self).filter("compoundKey = '\(habitID+date)'")
        
        try! realm.write {
            realm.delete(habitStatus)
        }
    }
    
    fileprivate func deleteHabitInRealm(habitID: String) {
        let realm = try! Realm()
        let habits = realm.objects(Habit.self).filter("id = '\(habitID)'")
        let habitStatus = realm.objects(HabitStatus.self).filter("id = '\(habitID)'")
        
        try! realm.write {
            realm.delete(habits)
            realm.delete(habitStatus)
        }
    }
    
    fileprivate func getNowDate() -> String {
        let dateFormat: DateFormatter = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        return dateFormat.string(from: Date())
    }
}
