//
//  CalendarView.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/05.
//

import UIKit
import FSCalendar

final class CalendarView: FSCalendar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setProperties()
    }
    
    private func setProperties() {
        cornerRadius = 20
        backgroundColor = Color.white
        locale = Locale(identifier: "ko_KR")
        headerHeight = 60
        firstWeekday = 2
        appearance.do {
            $0.headerMinimumDissolvedAlpha = 0.0
            $0.headerDateFormat = "YYYY년 M월"
            $0.headerTitleColor = Color.black
            $0.headerTitleFont = Font.medium14
            $0.weekdayTextColor = Color.gray5
            $0.weekdayFont = Font.medium12
            $0.todayColor = Color.black
            $0.titleDefaultColor = Color.black
            $0.subtitleDefaultColor = Color.gray4
            $0.titleFont = Font.medium12
        }
        setWeekendColor()
    }
    
    private func setWeekendColor(){
        calendarWeekdayView.weekdayLabels.forEach {
            if $0.text == "토"{
                $0.textColor = Color.blue
            } else if $0.text == "일"{
                $0.textColor = Color.red
            }
        }
    }
    
    func configureCalendar(studentIcon: StudentIcon){
        appearance.selectionColor = studentIcon.color
    }
    
    func configureStudentCalendar(studentIcon: StudentIcon){
        appearance.eventDefaultColor = studentIcon.color
        appearance.selectionColor = .clear
        appearance.titleSelectionColor = Color.black
        appearance.eventSelectionColor = studentIcon.color
        appearance.subtitleSelectionColor = Color.gray4
        appearance.todayColor = .clear
        appearance.titleTodayColor = Color.black
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

