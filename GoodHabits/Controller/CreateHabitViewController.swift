import UIKit
import FlexLayout
import PinLayout
import RealmSwift

class CreateHabitViewController: UIViewController {
    
    var mainView: CreateHabitView { return self.view as! CreateHabitView }
    override func loadView() { self.view = CreateHabitView() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingNavigationBar()
    }
    
    func settingNavigationBar() {
        let rightButton = UIBarButtonItem(
            title: "儲存",
            style: .plain,
            target: self,
            action: #selector(saveHabit)
        )
        navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc func saveHabit() {
        let habit = mainView.getFormDate()
        
        print("save (\(habit.title), \(habit.icon))")
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(habit)
        }
        self.navigationController?.popViewController(animated: true)
    }
}


