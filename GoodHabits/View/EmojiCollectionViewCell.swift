import UIKit

class EmojiCollectionViewCell: UICollectionViewCell {
    
    var emojiLabel:UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 5.0
        backgroundColor = UIColor(hex: "#555555")
        
        emojiLabel = UILabel(frame:CGRect(x: 0, y: 0, width: 60, height: 60))
        emojiLabel.textAlignment = .center
        self.addSubview(emojiLabel)
    }

    required init?(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
    }

}
