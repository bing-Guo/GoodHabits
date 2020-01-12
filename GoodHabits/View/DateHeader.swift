//
//  DateHeader.swift
//  GoodHabits
//
//  Created by Bing Guo on 2020/1/13.
//  Copyright © 2020 Bing Guo. All rights reserved.
//

import UIKit
import FlexLayout
import PinLayout
import JTAppleCalendar

class DateHeader: JTAppleCollectionReusableView {
    var monthTitle: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        monthTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        monthTitle.textColor = .black
        monthTitle.textAlignment = .center
        self.addSubview(monthTitle)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        monthTitle.pin.top().horizontally()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
