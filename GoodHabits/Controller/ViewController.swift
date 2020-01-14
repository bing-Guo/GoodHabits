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
        habitsTableView.backgroundColor = .white
        
        habitsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "habitsCell")
        view.addSubview(habitsTableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        print("reload")
        self.habitsTableView.reloadData()
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
        return self.todayHabits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "habitsCell", for: indexPath)
        let habit = self.todayHabits[indexPath.row]
        let habitText = habit.title
        let habitEmoji = habit.icon
        cell.textLabel?.text = "\(habitEmoji) \t \(habitText)"
        cell.textLabel?.font = UIFont(name: "Arial", size: 24)
        
        cell.backgroundColor = (habit.checked) ?UIColor(hex: self.greenColorHex) :.white
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let cell = tableView.cellForRow(at: indexPath)
        let chioseHabit = self.todayHabits[indexPath.row]
        let nowDateString = self.getNowDate()
        
        let checkAction = UIContextualAction(style: .normal, title: "Check") { (action, sourceView, completionHandler) in
            let habitStatus: HabitStatus = HabitStatus(id: chioseHabit.id, date: nowDateString)
            self.appendHabitStatusToRealm(habitStatus: habitStatus)
            cell?.backgroundColor = UIColor(hex: self.greenColorHex)
            completionHandler(true)
        }
        checkAction.backgroundColor = UIColor(hex: self.greenColorHex)
        checkAction.image = UIImage(systemName: "checkmark.circle")
        
        let unCheckAction = UIContextualAction(style: .normal, title: "Uncheck") { (action, sourceView, completionHandler) in
            self.deleteHabitStatusInRealm(habitID: chioseHabit.id, date: nowDateString)
            cell?.backgroundColor = .white
            completionHandler(true)
        }
        unCheckAction.backgroundColor = UIColor(hex: "#F0AD4E")
        unCheckAction.image = UIImage(systemName: "arrowshape.turn.up.left.circle")
        
        let swipeConfiguration: UISwipeActionsConfiguration
        if chioseHabit.checked {
            swipeConfiguration = UISwipeActionsConfiguration(actions: [unCheckAction])
        } else {
            swipeConfiguration = UISwipeActionsConfiguration(actions: [checkAction])
        }
        
        return swipeConfiguration
    }
    
    // pass to calendar
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CalendarViewController()
        vc.habitID = todayHabits[indexPath.row].id
        vc.habitTitle = todayHabits[indexPath.row].title
        self.navigationController?.pushViewController(vc, animated: true)
    
    }
    
    fileprivate func appendHabitStatusToRealm(habitStatus: HabitStatus) {
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(habitStatus)
        }
    }
    
    fileprivate func deleteHabitStatusInRealm(habitID: String, date: String) {
        let realm = try! Realm()
        let predicate = NSPredicate(format: "compoundKey = %s", habitID+date)
        let habitStatus = realm.objects(HabitStatus.self).filter(predicate)
        
        try! realm.write {
            realm.delete(habitStatus)
        }
    }
    
    fileprivate func getNowDate() -> String {
        let dateFormat: DateFormatter = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        return dateFormat.string(from: Date())
    }
}
