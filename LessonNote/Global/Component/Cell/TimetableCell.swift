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
    var courseItems: [ElliottEvent] = []
    private var notificationToken: NotificationToken?
    
    private let repository = StudentRepository()
    lazy var studentResults = repository.fetch()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setProperties()
        setLayouts()
        update()
    }
    
    private lazy var daySymbol = DateManager.shared.getDatesStartingFromMonday()
    
    func setProperties(){
        timetable.delegate = self
        timetable.dataSource = self
        setCourseItems()
        timetable.courseItems = courseItems
        timetable.borderColor = Color.gray2
        timetable.borderWidth = 0.5
        timetable.symbolBackgroundColor = Color.gray0
        timetable.courseItemTextSize = 11
        timetable.roundCorner = .all
        timetable.isFullBorder = true
        timetable.elliotBackgroundColor = Color.white
    }
    
    func setCourseItems(){
        studentResults.forEach { student in
            student.toElliotEvent().forEach { event in
                courseItems.append(event)
            }
        }
    }
    
    func update(){
        notificationToken = studentResults.observe { [weak self] (changes: RealmCollectionChange) in
            switch changes {
            case .initial:
                break
            case .update(let collectionType, let deletions, let insertions, let modifications):
                self?.setCourseItems()
                self?.timetable.makeTimeTable()
                break
            case .error(let error):
                print(error)
                break
            }
        }
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
        return elliotable.courseItems
    }
    
    
}
