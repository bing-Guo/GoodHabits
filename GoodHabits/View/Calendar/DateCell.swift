import UIKit
import FlexLayout
import PinLayout
import JTAppleCalendar

class DateCell: JTAppleCell {
    let rootFlexContainer = UIView()
    var dateLabel: UILabel!
    var todayLabel: UILabel!
    var checked: UIView!
    
    let circleWidth: CGFloat = 40
    let collectionViewCellWidth: CGFloat = 56
    var circleMargin: CGFloat {
        return (collectionViewCellWidth - circleWidth) / 2
    }
    let textWidth: CGFloat = 18
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        dateLabel = UILabel(frame: .zero)
        dateLabel.textColor = .white
        dateLabel.textAlignment = .center
        dateLabel.font = UIFont(name: "Arial", size: 18)
        
        todayLabel = UILabel(frame: .zero)
        todayLabel.textColor = .white
        todayLabel.textAlignment = .center
        todayLabel.text = "今"
        todayLabel.font = UIFont(name: "Arial", size: 10)
        
        checked = UIView(frame: .zero)
        checked.layer.cornerRadius = (circleWidth / 2)
        checked.layer.borderColor = UIColor(hex: "#5CB85C").cgColor
        checked.layer.borderWidth = 1.5
        
        rootFlexContainer.flex.direction(.column).define { (flex) in
            flex.addItem(checked).position(.absolute).width(circleWidth).height(circleWidth).top(circleMargin).left(circleMargin)
            
            flex.addItem().direction(.column).marginTop(18).alignItems(.center).define { (flex) in
                flex.addItem(dateLabel)
                flex.addItem(todayLabel)
            }
        }
        self.addSubview(rootFlexContainer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        rootFlexContainer.pin.top().horizontally().margin(pin.safeArea)
        rootFlexContainer.flex.layout(mode: .adjustHeight)
    }
    
    func isToday(_ bool: Bool) {
        if(bool){
            self.todayLabel.isHidden = false
            self.dateLabel.flex.marginTop(-6)
        }else{
            self.todayLabel.isHidden = true
        }
    }
    
    func isHeadDay() {
        self.checked.backgroundColor = UIColor(hex: "#5CB85C")
        self.checked.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        self.checked.flex.width(circleWidth + circleMargin)
    }
    
    func isContinueDay() {
        self.checked.backgroundColor = UIColor(hex: "#5CB85C")
        self.checked.layer.cornerRadius = 0
        self.checked.flex.width(collectionViewCellWidth+2).left(-1)
    }
    
    func isTailDay() {
        self.checked.backgroundColor = UIColor(hex: "#5CB85C")
        self.checked.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        self.checked.flex.width(circleWidth + circleMargin).left(0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
