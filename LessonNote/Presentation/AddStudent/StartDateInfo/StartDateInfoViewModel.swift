//
//  StartDateInfoViewModel.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/06.
//

import Foundation

final class StartDateInfoViewModel{
    var date: Observable<Date?> = Observable(nil)
    var weekday: Observable<Weekday> = Observable(.monday)
    var isValid: Observable<Bool> = Observable(false)
    var weekdays: [Weekday] = []
    
    init(){
        setInitialWeekdays()
    }
}

extension StartDateInfoViewModel {
    func storeData(){
        TempStudent.shared.lessonStartDate = date.value
        TempStudent.shared.startWeekday = weekday.value
    }
    func setInitialWeekdays(){
        TempStudent.shared.lessonTimes?.forEach({ lesson in
            weekdays.append(lesson.weekday)
        })
        weekday.value = weekdays.first ?? .monday
    }
}
    
