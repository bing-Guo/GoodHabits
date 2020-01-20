import UIKit
import RealmSwift

class CalendarViewController: UIViewController {
    var habitID = ""
    var habitTitle = ""
    var habitsData: [String: String] {
        var habitResult = [String: String]()
        let realm = try! Realm()
        let dataSource = realm.objects(HabitStatus.self).filter("id = '\(habitID)'")
        for data in dataSource{
            habitResult[data.date] = data.id
        }
        return habitResult
    }

    var mainView: CalendarView { return self.view as! CalendarView }
    override func loadView() { self.view = CalendarView() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(hex: "#333333")
        
        mainView.calendarDataSource = habitsData
        settingNavigationBar()
    }
    
    func settingNavigationBar() {
        navigationItem.title = habitTitle
        
        let font = UIFont(name: "Helvetica", size: 28)!
        
        let titleDict: NSDictionary = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: font
        ]
        
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.barTintColor = .white
        
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]
        
        
        self.navigationController?.navigationBar.barTintColor  = UIColor(hex: "#333333")
        
    }
}
