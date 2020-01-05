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
    @objc dynamic var icon = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
