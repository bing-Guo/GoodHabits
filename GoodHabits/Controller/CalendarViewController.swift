import UIKit
import RealmSwift

class CalendarViewController: UIViewController {
    var habitID = ""
    var habitTitle = ""
    var habitIcon = ""
    var habitsDataSource: [String: String] {
        var habitResult = [String: String]()
        let realm = try! Realm()
        let dataSource = realm.objects(HabitStatus.self).filter("id = '\(habitID)'")
        
        for data in dataSource {
            habitResult[data.date] = ""
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        for date in habitResult {
            
            let thisDateString = date.key
            let thisDate = formatter.date(from: thisDateString)
            
            var prevDateString: String {
                let date = Calendar.current.date(byAdding: .day, value: -1, to: thisDate!)
                return formatter.string(for: date)!
            }
            
            var nextDateString: String {
                let date = Calendar.current.date(byAdding: .day, value: 1, to: thisDate!)
                return formatter.string(for: date)!
            }
            
            if habitResult[prevDateString] != nil && habitResult[nextDateString] != nil {
                habitResult[thisDateString] = "continue"
            }
            else if habitResult[prevDateString] == nil && habitResult[nextDateString] != nil {
                habitResult[thisDateString] = "head"
            }
            else if habitResult[prevDateString] != nil && habitResult[nextDateString] == nil {
                habitResult[thisDateString] = "tail"
            }
            else {
                habitResult[thisDateString] = ""
            }
        }
        
        return habitResult
    }

    var mainView: CalendarView { return self.view as! CalendarView }
    override func loadView() { self.view = CalendarView() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(hex: "#333333")
        
        mainView.calendarDataSource = habitsDataSource
        mainView.titleLabel.text = "\(habitIcon) \(habitTitle)"
        settingNavigationBar()
    }
    
    func settingNavigationBar() {
        let font = UIFont(name: "Helvetica", size: 28)!
        
        let titleDict: NSDictionary = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: font
        ]
        
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.barTintColor = .white
        
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]
        
        self.navigationController?.navigationBar.barTintColor  = UIColor(hex: "#333333")
        
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(
            title: "",
            style: .plain,
            target: nil,
            action: nil
        )
    }
}
