import UIKit
import FlexLayout
import PinLayout

class CreateHabitView: UIView {
    fileprivate let rootFlexContainer = UIView()
    fileprivate var collectionView: UICollectionView!
    
    fileprivate var emojiArray: [String] = ["💧", "🍏", "🍎" , "🥑", "🍳", "🥦", "🏀", "💪", "😀", "😃", "😄", "😁", "😆", "😂", "🤣", "🧐", "🤓", "😎", "😊", "⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🎱", "🎷", "🎺", "🎻", "🚗", "🚲", "🛵", "📱", "❤️", "🧡"]
    fileprivate struct emojiCollectionCellItem{
        var index: Int?
        var emoji: String?
    }
    fileprivate var choiceEmoji = emojiCollectionCellItem()
            
    init() {
        super.init(frame: .zero)
        backgroundColor = .white

        let segmentedControl = UISegmentedControl(items: ["Intro", "FlexLayout", "PinLayout"])
        segmentedControl.selectedSegmentIndex = 0
        
        let nameColumnLabel = UILabel()
        nameColumnLabel.text = "名稱"
        nameColumnLabel.numberOfLines = 0
        
        let nameTextField = UITextField()
        nameTextField.placeholder = "輸入習慣名稱"
        nameTextField.borderStyle = .roundedRect
        nameTextField.clearButtonMode = .whileEditing
        nameTextField.returnKeyType = .done
        
        let emojiColumnLabel = UILabel()
        emojiColumnLabel.text = "圖示"
        emojiColumnLabel.numberOfLines = 0
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        layout.itemSize = CGSize(width: 40, height:40)
        
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(EmojiCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundColor = .white
        
        rootFlexContainer.flex.direction(.column).padding(12).define { (flex) in
            flex.addItem(nameColumnLabel).marginTop(12)
            flex.addItem(nameTextField).marginTop(12)
            flex.addItem(emojiColumnLabel).marginTop(12)
            flex.addItem(collectionView).height(400).marginTop(12)
        }
        
        addSubview(rootFlexContainer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        rootFlexContainer.pin.top().horizontally().margin(pin.safeArea)

        rootFlexContainer.flex.layout(mode: .adjustHeight)
    }
}

extension CreateHabitView: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 36
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! EmojiCollectionViewCell
        
        cell.emojiLabel.text = self.emojiArray[indexPath.row]

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.choiceEmoji.index = indexPath.row
        self.choiceEmoji.emoji = self.emojiArray[indexPath.row]
        print("你選擇 \(self.choiceEmoji)")
    }

}
