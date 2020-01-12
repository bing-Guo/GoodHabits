import UIKit

class CalendarViewController: UIViewController {

    var mainView: CalendarView { return self.view as! CalendarView }
    override func loadView() { self.view = CalendarView() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
}
