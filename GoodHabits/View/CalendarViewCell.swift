//
//  CalendarCellView.swift
//  GoodHabits
//
//  Created by Bing Guo on 2020/1/8.
//  Copyright © 2020 Bing Guo. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CalendarViewCell: JTAppleCell {
    var dateLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        dateLabel = UILabel(frame:CGRect(x: 0, y: 0, width: 40, height: 40))
        dateLabel.textColor = .black
        dateLabel.textAlignment = .center
        self.addSubview(dateLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
