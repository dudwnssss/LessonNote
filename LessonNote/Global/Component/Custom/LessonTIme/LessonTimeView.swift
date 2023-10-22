//
//  LessonTimeView.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/01.
//

import UIKit

final class LessonTimeView: BaseView{
    
    let weekdayLabel = UILabel()
    let lessonTimeLabel = UILabel()
    let separatorView = SeparatorView(color: Color.gray1)
    
    init(lessonSchedule: LessonSchedule, color: UIColor){
        weekdayLabel.text = Weekday(rawValue: lessonSchedule.weekday)?.title
        weekdayLabel.textColor = color
        lessonTimeLabel.text = DateManager.shared.buildTimeRangeString(startDate: lessonSchedule.startTime, endDate: lessonSchedule.endTime)
        super.init(frame: .zero)
    }
    
    override func setProperties() {
        weekdayLabel.do {
            $0.font = Font.bold14
        }
        lessonTimeLabel.do {
            $0.font = Font.medium14
        }
    }
    
    override func setLayouts() {
        addSubviews(weekdayLabel, lessonTimeLabel, separatorView)

        weekdayLabel.snp.makeConstraints {
            $0.leading.equalTo(separatorView)
            $0.bottom.equalTo(separatorView.snp.top).offset(-4)
        }
        lessonTimeLabel.snp.makeConstraints {
            $0.leading.equalTo(weekdayLabel.snp.trailing).offset(8)
            $0.centerY.equalTo(weekdayLabel)
        }
        
        separatorView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.width.equalTo(190.adjusted)
        }
        
        snp.makeConstraints {
            $0.height.equalTo(30)
        }
    }
}

