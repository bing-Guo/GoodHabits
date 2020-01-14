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
        self.view.backgroundColor = .white
        
        self.navigationItem.title = habitTitle
        
        mainView.calendarDataSource = habitsData
    }
}
