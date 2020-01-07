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
        var habitStatus: [HabitStatus] {
            let nowDateString = self.getNowDate()
            let realm = try! Realm()
            return Array(realm.objects(HabitStatus.self).filter("date = '\(nowDateString)'"))
        }
        
        var habitsData: [Habit] {
            let realm = try! Realm()
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
        
        let shareAction = UIContextualAction(style: .normal, title: "Check") { (action, sourceView, completionHandler) in
            
            let chioseHabit = self.todayHabits[indexPath.row]
            let nowDateString = self.getNowDate()
            
            let realm = try! Realm()
            
            let habitStatus: HabitStatus = HabitStatus(id: chioseHabit.id, date: nowDateString)
            
            try! realm.write {
                realm.add(habitStatus)
            }
            
            let cell = tableView.cellForRow(at: indexPath)
            cell?.backgroundColor = UIColor(hex: self.greenColorHex)
            print("fileURL: \(realm.configuration.fileURL!)")
            
            completionHandler(true)
        }
        
        shareAction.backgroundColor = UIColor(hex: self.greenColorHex)
        shareAction.image = UIImage(systemName: "checkmark.circle")
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [shareAction])
        return swipeConfiguration
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(CalendarViewController(), animated: true)
    
    }
    
    fileprivate func getNowDate() -> String {
        let dateFormat: DateFormatter = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        return dateFormat.string(from: Date())
    }
}
