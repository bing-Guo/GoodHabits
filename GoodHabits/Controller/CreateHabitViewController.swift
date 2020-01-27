import UIKit
import FlexLayout
import PinLayout
import RealmSwift

class CreateHabitViewController: UIViewController {
    
    var mainView: CreateHabitView { return self.view as! CreateHabitView }
    override func loadView() { self.view = CreateHabitView() }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor._deep_gray
        settingNavigationBar()
    }
    
    // MARK: - Navigation Bar Setting
    
    func settingNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "儲存",
            style: .plain,
            target: self,
            action: #selector(saveHabit)
        )
        
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(
            title: "",
            style: .plain,
            target: nil,
            action: nil
        )
        
        let attributes: NSDictionary = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 24)!
        ]
       
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes(attributes as? [NSAttributedString.Key : Any], for: .normal)
    }
    
    // MARK: - Action
    
    @objc func saveHabit() {
        let habit = mainView.getFormDate()
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(habit)
        }
        self.navigationController?.popViewController(animated: true)
    }
}


