import UIKit
import FlexLayout
import PinLayout
import JTAppleCalendar

class DateCell: JTAppleCell {
    let rootFlexContainer = UIView()
    var dateLabel = UILabel()
    var todayLabel = UILabel()
    var circle = UIView()
    
    let circleWidth: CGFloat = 40
    let collectionViewCellWidth: CGFloat = 56
    var circleMargin: CGFloat {
        return (collectionViewCellWidth - circleWidth) / 2
    }
    let textWidth: CGFloat = 18
    
    // MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()

        rootFlexContainer.pin.top().horizontally().margin(pin.safeArea)
        rootFlexContainer.flex.layout(mode: .adjustHeight)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        dateLabel.textColor = .white
        dateLabel.textAlignment = .center
        dateLabel.font = UIFont(name: "Arial", size: 16)
        
        todayLabel.textColor = .white
        todayLabel.textAlignment = .center
        todayLabel.text = "今"
        todayLabel.font = UIFont(name: "Arial", size: 10)
        todayLabel.isHidden = true
        
        circle.layer.cornerRadius = (circleWidth / 2)
        circle.layer.borderColor = UIColor._standard_green.cgColor
        circle.layer.borderWidth = 1.5
            
        rootFlexContainer.flex.direction(.column).define { (flex) in
            flex.addItem(circle).position(.absolute).width(circleWidth).height(circleWidth).top(circleMargin).left(circleMargin)
            
            flex.addItem().direction(.column).marginTop(18).alignItems(.center).define { (flex) in
                flex.addItem(dateLabel).width(25)
                flex.addItem(todayLabel)
            }
        }
        self.addSubview(rootFlexContainer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper
    func reset() {
        self.todayLabel.isHidden = true
        self.dateLabel.flex.marginTop(0)
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
        self.circle.backgroundColor = UIColor._standard_green
        self.circle.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        self.circle.flex.width(circleWidth + circleMargin + 10)
    }
    
    func isContinueDay() {
        self.circle.backgroundColor = UIColor._standard_green
        self.circle.layer.cornerRadius = 0
        self.circle.flex.width(collectionViewCellWidth)
    }
    
    func isTailDay() {
        self.circle.backgroundColor = UIColor._standard_green
        self.circle.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        self.circle.flex.width(circleWidth + circleMargin)
    }
}
