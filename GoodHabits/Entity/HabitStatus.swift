//
//  HabitsStatus.swift
//  GoodHabits
//
//  Created by Bing Guo on 2020/1/5.
//  Copyright © 2020 Bing Guo. All rights reserved.
//

import Foundation
import RealmSwift

class HabitStatus: Object {
    
    @objc dynamic var id = ""
    @objc dynamic var date = ""
    @objc dynamic var compoundKey = ""
    
    convenience init(id: String, date: String) {
        self.init()
        self.id = id
        self.date = date
        self.compoundKey = compoundKeyValue()
    }
    
    override static func primaryKey() -> String? {
        return "compoundKey"
    }
    
    func compoundKeyValue() -> String {
        return "\(id)\(date)"
    }
}
