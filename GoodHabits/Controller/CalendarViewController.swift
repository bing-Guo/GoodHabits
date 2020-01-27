import UIKit
import RealmSwift

class CalendarViewController: UIViewController {
    var habit: Habit = Habit()
    
    var habitsDataSource: [String: String] {
        var habitResult = [String: String]()
        let realm = try! Realm()
        let dataSource = realm.objects(HabitStatus.self).filter("id = '\(habit.id)'")
        
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
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor._deep_gray
        
        mainView.calendarDataSource = habitsDataSource
        mainView.titleLabel.text = "\(habit.icon) \(habit.title)"
    }
}
