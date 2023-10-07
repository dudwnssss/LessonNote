//
//  LessonTimeView.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/01.
//

import UIKit

class LessonTimeView: BaseView{
    
    let weekdayLabel = UILabel()
    let lessonTimeLabel = UILabel()
    let separatorView = SeparatorView()
    
    init(lessonSchedule: LessonSchedule, color: UIColor){
        weekdayLabel.text = Weekday(rawValue: lessonSchedule.weekday)?.title
        weekdayLabel.textColor = color
        lessonTimeLabel.text = Date.buildTimeRangeString(startDate: lessonSchedule.startTime, endDate: lessonSchedule.endTime)
        super.init(frame: .zero)
    }
    
    override func setProperties() {
        weekdayLabel.do {
            $0.font = Font.bold14
        }
        lessonTimeLabel.do {
            $0.font = Font.medium14
        }
        separatorView.do {
            $0.backgroundColor = .systemPink
        }

    }
    override func setLayouts() {
        addSubviews(weekdayLabel, lessonTimeLabel, separatorView)
        separatorView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        weekdayLabel.snp.makeConstraints {
            $0.leading.equalTo(separatorView)
            $0.bottom.equalTo(separatorView.snp.top).offset(-4)
        }
        lessonTimeLabel.snp.makeConstraints {
            $0.leading.equalTo(weekdayLabel.snp.trailing).offset(8)
            $0.centerY.equalTo(weekdayLabel)
        }
        snp.makeConstraints {
            $0.height.equalTo(30)
        }
    }
}

