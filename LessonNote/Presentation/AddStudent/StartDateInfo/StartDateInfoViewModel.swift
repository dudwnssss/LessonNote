//
//  StartDateInfoViewModel.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/06.
//

import Foundation

final class StartDateInfoViewModel{
    var date: CustomObservable<Date?> = CustomObservable(nil)
    var weekday: CustomObservable<Weekday> = CustomObservable(.monday)
    var isValid: CustomObservable<Bool> = CustomObservable(false)
    var weekdays: [Weekday] = []
    var message: String?
    
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
    
    func checkValidation(){
        guard let date = date.value else {
            message = "수업 시작일을 선택해주세요"
            isValid.value = false
            return
        }
        message = nil
        isValid.value = true
    }
}
    
