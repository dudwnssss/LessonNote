//
//  LessonInfoViewModel.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/05.
//

import Foundation

final class LessonInfoViewModel{
    
    var lessonTimeList: [LessonTime] = []
    var isChecked: Observable<Bool> = Observable(false)
    var weekCount: Observable<Int> = Observable(2)
    var weekDay: Observable<[Weekday]?> = Observable(nil)
}

extension LessonInfoViewModel{
    func storeData(){
        TempStudent.shared.lessonTimes = lessonTimeList
        TempStudent.shared.weekCount = weekCount.value
    }
    func setWeekCount(){
        if isChecked.value {
            weekCount.value = 2
        } else {
            weekCount.value = 1
        }
    }
}
