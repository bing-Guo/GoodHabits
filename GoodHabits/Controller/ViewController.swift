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
        habitsTableView.backgroundColor = .white
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
        self.view.backgroundColor = .white
        self.title = "習慣"
        normalMode()
    }
    
    func normalMode() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "trash"),
            style: .plain,
            target: self,
            action: #selector(switchEditMode)
        )

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(passToCreateHabitView)
        )
    }
    
    func editMode() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(switchEditMode)
        )

        self.navigationItem.rightBarButtonItem = nil
    }
    
    @objc func passToCreateHabitView() {
        self.navigationController?.pushViewController(CreateHabitViewController(), animated: true)
    }
    
    @objc func switchEditMode() {
        habitsTableView.setEditing(!habitsTableView.isEditing, animated: true)
        
        if (!habitsTableView.isEditing) {
            normalMode()
        } else {
            editMode()
        }
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
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let cell = tableView.cellForRow(at: indexPath) as! HabitTableViewCell
        let chioseHabit = self.todayHabits[indexPath.row]
        let nowDateString = self.getNowDate()
        
        let checkAction = UIContextualAction(style: .normal, title: "Check") { (action, sourceView, completionHandler) in
            let habitStatus: HabitStatus = HabitStatus(id: chioseHabit.id, date: nowDateString)
            self.appendHabitStatusToRealm(habitStatus: habitStatus)
            
            cell.isCheck(true)
            completionHandler(true)
        }
        checkAction.backgroundColor = UIColor(hex: self.greenColorHex)
        checkAction.image = UIImage(systemName: "checkmark.circle")
        
        let unCheckAction = UIContextualAction(style: .normal, title: "Uncheck") { (action, sourceView, completionHandler) in
            self.deleteHabitStatusInRealm(habitID: chioseHabit.id, date: nowDateString)
            cell.isCheck(false)
            completionHandler(true)
        }
        unCheckAction.backgroundColor = UIColor(hex: "#F0AD4E")
        unCheckAction.image = UIImage(systemName: "arrowshape.turn.up.left.circle")
        
        let deleteAction = UIContextualAction(style: .normal, title: "Delete") { (action, sourceView, completionHandler) in
            self.deleteHabitInRealm(habitID: chioseHabit.id)
            
            
            self.habitsTableView.beginUpdates()
            self.habitsTableView.deleteRows(at: [indexPath], with: .fade)
            self.habitsTableView.endUpdates()
            completionHandler(true)
        }
        deleteAction.backgroundColor = UIColor(hex: "#F0AD4E")
        
        var swipeConfiguration: UISwipeActionsConfiguration? = nil
        
        if(!tableView.isEditing) {
            if chioseHabit.checked {
                swipeConfiguration = UISwipeActionsConfiguration(actions: [unCheckAction])
            } else {
                swipeConfiguration = UISwipeActionsConfiguration(actions: [checkAction])
            }
        }else {
            swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
        }
        
        return swipeConfiguration
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
