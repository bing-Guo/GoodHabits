import Foundation
import RealmSwift

class Habit: Object {
    
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var title = ""
    @objc dynamic var icon = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
