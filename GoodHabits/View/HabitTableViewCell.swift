import UIKit
import FlexLayout
import PinLayout

class HabitTableViewCell: UITableViewCell {
    static let reuseIdentifier = "habitsCell"
//    var rootFlexContainer = UIView()
    var titleLabel = UILabel()
    var iconLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        self.iconLabel.font = UIFont(name: "Arial", size: 32)
        self.titleLabel.font = UIFont(name: "Arial", size: 24)
        self.titleLabel.numberOfLines = 0
        
        contentView
            .flex
            .direction(.column)
            .padding(20)
            .margin(UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10))
            .define{ (flex) in
            flex.addItem().direction(.row).define { (flex) in
                flex.addItem(iconLabel).size(40)
                flex.addItem(titleLabel).marginLeft(10).grow(1)
            }
        }
        contentView.backgroundColor = UIColor(hex: "#EEEEEE")
        contentView.layer.cornerRadius = CGFloat(10)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.pin.vCenter()
        contentView.flex.layout(mode: .adjustHeight)
    }
    
    func isCheck(_ status: Bool) {
        if(status){
            self.contentView.backgroundColor = UIColor(hex: "#5CB85C")
        }else{
            self.contentView.backgroundColor = UIColor(hex: "#EEEEEE")
        }
    }
    
    
}
