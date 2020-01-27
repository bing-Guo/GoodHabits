import UIKit
import FlexLayout
import PinLayout

class HabitTableViewCell: UITableViewCell {
    static let reuseIdentifier = "habitsCell"
    var titleLabel = UILabel()
    var iconLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // contentView
        backgroundColor = UIColor._deep_gray
        selectionStyle = .none
        
        // icon label
        self.iconLabel.font = UIFont(name: "Arial", size: 32)
        
        // title label
        self.titleLabel.font = UIFont(name: "Arial", size: 24)
        self.titleLabel.textColor = .white
        self.titleLabel.numberOfLines = 0
        
        // flex layout
        contentView
            .flex
            .direction(.column)
            .padding(20)
            .margin(UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10))
            .define{ (flex) in
            flex.addItem().direction(.row).define { (flex) in
                flex.addItem(iconLabel).size(40)
                flex.addItem(titleLabel).marginLeft(10).grow(1)
            }
        }
        contentView.backgroundColor = UIColor._deep_gray
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
    
    // MARK: - Action
    
    func isCheck(_ status: Bool) {
        if(status){
            self.contentView.backgroundColor = UIColor._standard_green
        }else{
            self.contentView.backgroundColor = UIColor._standard_gray
        }
    }
}
