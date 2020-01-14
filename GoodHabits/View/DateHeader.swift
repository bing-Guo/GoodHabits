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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        monthTitle = UILabel(frame: .zero)
        monthTitle.textColor = .black
        monthTitle.textAlignment = .center
        
        monLabel.text = "MON"
        tueLabel.text = "TUE"
        wedLabel.text = "WED"
        thuLabel.text = "THU"
        friLabel.text = "FRI"
        satLabel.text = "SAT"
        sunLabel.text = "SUN"
        monLabel.textAlignment = .center
        tueLabel.textAlignment = .center
        wedLabel.textAlignment = .center
        thuLabel.textAlignment = .center
        friLabel.textAlignment = .center
        satLabel.textAlignment = .center
        sunLabel.textAlignment = .center
        
        rootFlexContainer.flex.direction(.column).define { (flex) in
            flex.addItem().direction(.row).alignItems(.center).define { (flex) in
                flex.addItem(monthTitle).margin(12).grow(1)
            }
            
            flex.addItem().direction(.row).define { (flex) in
                flex.addItem(monLabel).grow(1)
                flex.addItem(tueLabel).grow(1)
                flex.addItem(wedLabel).grow(1)
                flex.addItem(thuLabel).grow(1)
                flex.addItem(friLabel).grow(1)
                flex.addItem(satLabel).grow(1)
                flex.addItem(sunLabel).grow(1)
            }
        }
        self.addSubview(rootFlexContainer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        rootFlexContainer.pin.top().horizontally()
        rootFlexContainer.flex.layout(mode: .adjustHeight)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
