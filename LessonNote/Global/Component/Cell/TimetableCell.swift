//
//  TimeTableCell.swift
//  TimeTable
//
//  Created by 임영준 on 2023/09/26.
//

import UIKit
import RealmSwift

class TimetableCell: UICollectionViewCell{
    
    let timetable = Elliotable()
    var courseItems: [ElliottEvent] = []{
        didSet{
            timetable.reloadData()
        }
    }
    
    private lazy var daySymbol = DateManager.shared.getDatesStartingFromMonday()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setProperties()
        setLayouts()
    }
    
    func setProperties(){
        print("course items", courseItems)
        timetable.do {
            $0.delegate = self
            $0.dataSource = self
            $0.courseItems = courseItems
            $0.borderColor = Color.gray2
            $0.borderWidth = 0.5
            $0.symbolBackgroundColor = Color.gray0
            $0.courseItemTextSize = 11
            $0.roundCorner = .all
            $0.isFullBorder = true
            $0.elliotBackgroundColor = Color.white
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        courseItems = []
    }
    
    
    func setLayouts(){
        contentView.addSubview(timetable)
        timetable.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension TimetableCell: ElliotableDelegate, ElliotableDataSource{
    func elliotable(elliotable: Elliotable, didSelectCourse selectedCourse: ElliottEvent) {
        dump(selectedCourse.student)
    }
    
    func elliotable(elliotable: Elliotable, didLongSelectCourse longSelectedCourse: ElliottEvent) {
    }
    
    func elliotable(elliotable: Elliotable, at dayPerIndex: Int) -> String {
        return daySymbol[dayPerIndex]
    }
    
    func numberOfDays(in elliotable: Elliotable) -> Int {
        return daySymbol.count
    }
    
    func courseItems(in elliotable: Elliotable) -> [ElliottEvent] {
        return courseItems
    }
}
 
