import UIKit
import FlexLayout
import PinLayout

class CreateHabitView: UIView {
    fileprivate let rootFlexContainer = UIView()
    fileprivate var collectionView: UICollectionView!
    fileprivate var nameTextField = UITextField()
    fileprivate var nameColumnLabel = UILabel()
    fileprivate var emojiColumnLabel = UILabel()
    fileprivate var emojiArray: [String] = ["💧", "🍎" , "🥑", "🍳", "🥦", "🥃", "☕️", "🏀", "🧗", "🏃‍♂️", "🏄‍♂️", "🚵‍♀️", "🚶", "⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🎱", "🎷", "💪", "😀", "😃", "😄", "😁", "😆", "😂", "🤣", "🧐", "🤓", "😎", "😊", "🚗", "🚲", "🛵", "🚅", "✈️", "📱", "🎮", "❤️", "🧡", "👬", "🍱", "🍙", "🍽", "🧻"]
    fileprivate struct emojiCollectionCellItem {
        var index: Int?
        var emoji: String?
    }
    fileprivate var choiceEmoji = emojiCollectionCellItem()
    
    // MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()

        rootFlexContainer.pin.top().horizontally().margin(pin.safeArea)
        rootFlexContainer.flex.layout(mode: .adjustHeight)
    }
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        
        nameTextField.placeholder = ""
        nameTextField.borderStyle = .roundedRect
        nameTextField.clearButtonMode = .whileEditing
        nameTextField.returnKeyType = .done
        nameTextField.font = UIFont(name: "Arial", size: 24)
        nameTextField.backgroundColor = UIColor._standard_gray
        nameTextField.textColor = .white
        
        nameColumnLabel.text = "名稱"
        nameColumnLabel.numberOfLines = 0
        nameColumnLabel.font = UIFont(name: "Arial", size: 24)
        nameColumnLabel.textColor = .white
        
        emojiColumnLabel.text = "圖示"
        emojiColumnLabel.numberOfLines = 0
        emojiColumnLabel.font = UIFont(name: "Arial", size: 24)
        emojiColumnLabel.textColor = .white

        let segmentedControl = UISegmentedControl(items: ["Intro", "FlexLayout", "PinLayout"])
        segmentedControl.selectedSegmentIndex = 0
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        layout.itemSize = CGSize(width: 60, height:60)
        
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(EmojiCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundColor = UIColor._deep_gray
        
        rootFlexContainer.flex.direction(.column).padding(12).define { (flex) in
            flex.addItem(nameColumnLabel).marginTop(12)
            flex.addItem(nameTextField).padding(5).marginTop(12)
            flex.addItem(emojiColumnLabel).marginTop(12)
            flex.addItem(collectionView).height(650).marginTop(12)
        }
        
        addSubview(rootFlexContainer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Action
    
    fileprivate func getNameTextFieldValue() -> String {
        if let text = nameTextField.text {
            return text
        }
        return ""
    }
    
    fileprivate func getChoiseEmoji() -> String {
        if let text = self.choiceEmoji.emoji {
            return text
        }
        return ""
    }
    
    // MARK: - Helper
    
    func getFormDate() -> Habit {
        let habit: Habit = Habit()
        habit.title = getNameTextFieldValue()
        habit.icon = getChoiseEmoji()
        
        return habit
    }
}

extension CreateHabitView: UICollectionViewDelegate, UICollectionViewDataSource{
    
    // MARK: - collection view data source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emojiArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! EmojiCollectionViewCell
        
        cell.emojiLabel.text = self.emojiArray[indexPath.row]

        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.choiceEmoji.index = indexPath.row
        self.choiceEmoji.emoji = self.emojiArray[indexPath.row]
        
        collectionView.cellForItem(at: indexPath)?.backgroundColor = .lightGray
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.backgroundColor = UIColor._standard_gray
    }

}
