import UIKit
import FlexLayout
import PinLayout
import JTAppleCalendar

class CalendarView: UIView {
    fileprivate let rootFlexContainer = UIView()
    fileprivate var calendarView: JTAppleCalendarView!
    
    var calendarDataSource = [String: String]()
    var titleLabel = UILabel()
    var lineBlock = UIView()
    
    // MARK: - Life cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()

        rootFlexContainer.pin.top().horizontally().margin(pin.safeArea)
        calendarView.pin.height(400)

        rootFlexContainer.flex.layout(mode: .adjustHeight)
    }
    
    init() {
        super.init(frame: .zero)
        
        titleLabel.text = ""
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: "Helvetica", size: 28)
        titleLabel.textAlignment = .center
        
        lineBlock.layer.backgroundColor = UIColor.white.cgColor
        
        calendarView = JTAppleCalendarView(frame: .zero)
        calendarView.register(DateCell.self, forCellWithReuseIdentifier: "dateCell")
        calendarView.register(DateHeader.self,
                              forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                              withReuseIdentifier: "DateHeader")
        calendarView.ibCalendarDelegate = self
        calendarView.ibCalendarDataSource = self
        calendarView.scrollDirection = .horizontal
        calendarView.scrollingMode = .stopAtEachCalendarFrame
        calendarView.showsHorizontalScrollIndicator = false
        calendarView.backgroundColor = UIColor._deep_gray
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
        calendarView.scrollToDate(Date(),animateScroll: false)
        
        rootFlexContainer.flex.direction(.column).padding(12).define { (flex) in
            flex.addItem(titleLabel).marginTop(10)
            flex.addItem(lineBlock).marginTop(20).height(1)
            flex.addItem(calendarView).marginTop(20)
        }
        
        addSubview(rootFlexContainer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension CalendarView: JTAppleCalendarViewDataSource, JTAppleCalendarViewDelegate {
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        let cell = cell as! DateCell
        cell.dateLabel.text = cellState.text
        
        configureCell(view: cell, cellState: cellState)
    }
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"

        let startDate = formatter.date(from: "2019 12 01")!
        let endDate = Date()
        
        let parameters = ConfigurationParameters(
            startDate: startDate,
            endDate: endDate,
            generateInDates: .forAllMonths,
            generateOutDates: .off)
        return parameters
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "dateCell", for: indexPath) as! DateCell
        cell.dateLabel.text = cellState.text
        
        self.calendar(calendar, willDisplay: cell, forItemAt: date, cellState: cellState, indexPath: indexPath)
        
        return cell
    }
    
    func configureCell(view: JTAppleCell?, cellState: CellState) {
        guard let cell = view as? DateCell else { return }
        cell.dateLabel.text = cellState.text
        handleCellTextColor(cell: cell, cellState: cellState)
        handleCellEvents(cell: cell, cellState: cellState)
        handleCellIsToday(cell: cell, cellState: cellState)
    }
    
    fileprivate func handleCellTextColor(cell: DateCell, cellState: CellState) {
        if cellState.dateBelongsTo == .thisMonth {
            cell.dateLabel.textColor = .white
        } else {
            cell.dateLabel.textColor = .lightGray
        }
    }
    
    func handleCellEvents(cell: DateCell, cellState: CellState) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: cellState.date)
        
        if let statue = calendarDataSource[dateString] {
            cell.circle.isHidden = false
            
            if statue == "tail" {
                cell.isTailDay()
            }else if statue == "head" {
                cell.isHeadDay()
            }else if statue == "continue"{
                cell.isContinueDay()
            }else {}
        } else {
            cell.circle.isHidden = true
        }
    }
    
    fileprivate func handleCellIsToday(cell: DateCell, cellState: CellState) {
        // 確保在reuse時候還是保持正常
        cell.reset()
        
        let today = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: cellState.date)
        let todayString = formatter.string(from: today)
        
        if(todayString == dateString) {
            cell.isToday(true)
        }
    }
    
    func calendar(_ calendar: JTAppleCalendarView, headerViewForDateRange range: (start: Date, end: Date), at indexPath: IndexPath) -> JTAppleCollectionReusableView {
        let formatter = DateFormatter()  // Declare this outside, to avoid instancing this heavy class multiple times.
        formatter.dateFormat = "MMMM yyyy"

        let header = calendar.dequeueReusableJTAppleSupplementaryView(withReuseIdentifier: "DateHeader", for: indexPath) as! DateHeader
        header.monthTitle.text = formatter.string(from: range.start)
        
        return header
    }
    
    func calendarSizeForMonths(_ calendar: JTAppleCalendarView?) -> MonthSize? {
        return MonthSize(defaultSize: 120)
    }
}
