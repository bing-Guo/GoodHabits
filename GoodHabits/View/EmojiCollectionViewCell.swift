import UIKit

class EmojiCollectionViewCell: UICollectionViewCell {
    
    var emojiLabel:UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.borderWidth = 1
        layer.borderColor = UIColor(red:211/255, green:211/255, blue:211/255, alpha: 1).cgColor
        layer.cornerRadius = 2.0
        backgroundColor = .white
        
        emojiLabel = UILabel(frame:CGRect(x: 0, y: 0, width: 40, height: 40))
        emojiLabel.textAlignment = .center
        self.addSubview(emojiLabel)
    }

    required init?(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
    }

}
