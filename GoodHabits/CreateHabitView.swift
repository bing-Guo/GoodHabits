// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.
//
// Created by Luc Dion on 2017-07-17.
import UIKit
import FlexLayout
import PinLayout

class CreateHabitView: UIView {
    fileprivate let rootFlexContainer = UIView()
    fileprivate var collectionView: UICollectionView!
    
    var emojiArray: [String] = ["💧", "🍏", "🍎" , "🥑", "🍳", "🥦", "🏀", "💪", "😀", "😃", "😄", "😁", "😆", "😂", "🤣", "🧐", "🤓", "😎", "😊", "⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🎱", "🎷", "🎺", "🎻", "🚗", "🚲", "🛵", "📱", "❤️", "🧡"]
            
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
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 30, height:30)

        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(EmojiCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundColor = .white
        
        print(frame.size.width)
        print(frame.size.height)
        rootFlexContainer.flex.direction(.column).padding(12).define { (flex) in
            flex.addItem(nameColumnLabel).marginTop(12)
            flex.addItem(nameTextField).marginTop(12)
            flex.addItem(emojiColumnLabel).marginTop(12)
            flex.addItem(collectionView).height(200).marginTop(12)
        }
        
        print(emojiArray.count)
        
        addSubview(rootFlexContainer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        // Layout the flexbox container using PinLayout
        // NOTE: Could be also layouted by setting directly rootFlexContainer.frame
        rootFlexContainer.pin.top().horizontally().margin(pin.safeArea)

        // Then let the flexbox container layout itself
        rootFlexContainer.flex.layout(mode: .adjustHeight)
    }
}

extension CreateHabitView: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 36
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! EmojiCollectionViewCell
        print(indexPath.row)
        cell.backgroundColor = .white
        cell.emojiLabel.text = self.emojiArray[indexPath.row]

        return cell
    }
}
