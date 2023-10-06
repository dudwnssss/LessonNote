//
//  CalendarView.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/05.
//

import UIKit
import FSCalendar

class CalendarView: FSCalendar {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setProperties()
        setLayouts()
    }
    
    func setProperties() {
        
        cornerRadius = 20
        locale = Locale(identifier: "ko_KR")
        headerHeight = 60
        
        appearance.do {
            $0.headerMinimumDissolvedAlpha = 0.0
            $0.headerDateFormat = "YYYY년 M월"
            $0.headerTitleColor = Color.black
            $0.headerTitleFont = Font.medium14
            $0.weekdayTextColor = Color.gray5
            $0.weekdayFont = Font.medium12
            
            $0.titleDefaultColor = Color.black
            $0.titleFont = Font.medium12
            $0.selectionColor = .black
            
        }
        setWeekendColor()

    }
    
    func setLayouts() {
        
    }
    
    
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setWeekendColor(){
        calendarWeekdayView.weekdayLabels.forEach {
            if $0.text == "토"{
                $0.textColor = Color.blue
            } else if $0.text == "일"{
                $0.textColor = Color.red
            }
        }
    }
    
}

//extension CalendarView: FSCalendarDelegateAppearance {
//    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
//        let day = Calendar.current.component(.weekday, from: date) - 1
//
//    }
//}