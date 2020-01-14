import UIKit
import FlexLayout
import PinLayout
import JTAppleCalendar

class DateCell: JTAppleCell {
    let rootFlexContainer = UIView()
    var dateLabel: UILabel!
    var checked: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        dateLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        dateLabel.textColor = .black
        dateLabel.textAlignment = .center
        
        checked = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 10))
        checked.backgroundColor = .red
        
        rootFlexContainer.flex.direction(.column).define { (flex) in
            flex.addItem(dateLabel)
            flex.addItem(checked).marginTop(12)
        }
        self.addSubview(rootFlexContainer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        rootFlexContainer.pin.top().horizontally().margin(pin.safeArea)
        rootFlexContainer.flex.layout(mode: .adjustHeight)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
