import UIKit
import FlexLayout
import PinLayout
import JTAppleCalendar

class DateHeader: JTAppleCollectionReusableView {
    let rootFlexContainer = UIView()
    var monthTitle = UILabel(frame: .zero)
    var monLabel = UILabel(frame: .zero)
    var tueLabel = UILabel(frame: .zero)
    var wedLabel = UILabel(frame: .zero)
    var thuLabel = UILabel(frame: .zero)
    var friLabel = UILabel(frame: .zero)
    var satLabel = UILabel(frame: .zero)
    var sunLabel = UILabel(frame: .zero)
    
    // MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        rootFlexContainer.pin.top().horizontally()
        rootFlexContainer.flex.layout(mode: .adjustHeight)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        monthTitle = UILabel(frame: .zero)
        monthTitle.textColor = .white
        monthTitle.textAlignment = .center
        monthTitle.font = UIFont(name: "Arial", size: 28)
        
        monLabel.text = "一"
        tueLabel.text = "二"
        wedLabel.text = "三"
        thuLabel.text = "四"
        friLabel.text = "五"
        satLabel.text = "六"
        sunLabel.text = "日"
        monLabel.textAlignment = .center
        tueLabel.textAlignment = .center
        wedLabel.textAlignment = .center
        thuLabel.textAlignment = .center
        friLabel.textAlignment = .center
        satLabel.textAlignment = .center
        sunLabel.textAlignment = .center
        monLabel.textColor = .white
        tueLabel.textColor = .white
        wedLabel.textColor = .white
        thuLabel.textColor = .white
        friLabel.textColor = .white
        satLabel.textColor = .white
        sunLabel.textColor = .white
        
        rootFlexContainer.flex.direction(.column).define { (flex) in
            flex.addItem().direction(.row).alignItems(.center).define { (flex) in
                flex.addItem(monthTitle).margin(12).grow(1)
            }
            
            flex.addItem().direction(.row).marginTop(20).define { (flex) in
                flex.addItem(sunLabel).grow(1)
                flex.addItem(monLabel).grow(1)
                flex.addItem(tueLabel).grow(1)
                flex.addItem(wedLabel).grow(1)
                flex.addItem(thuLabel).grow(1)
                flex.addItem(friLabel).grow(1)
                flex.addItem(satLabel).grow(1)
            }
        }
        self.addSubview(rootFlexContainer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
