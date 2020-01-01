//
//  CreateHabitViewCell.swift
//  GoodHabits
//
//  Created by Bing Guo on 2020/1/1.
//  Copyright © 2020 Bing Guo. All rights reserved.
//

import UIKit

class EmojiCollectionViewCell: UICollectionViewCell {
    
    var emojiLabel:UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.borderColor = UIColor(red:211/255, green:211/255, blue:211/255, alpha: 1).cgColor
        
        emojiLabel = UILabel(frame:CGRect(x: 0, y: 0, width: 30, height: 30))
        emojiLabel.textAlignment = .center
        self.addSubview(emojiLabel)
    }

    required init?(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
    }

}
