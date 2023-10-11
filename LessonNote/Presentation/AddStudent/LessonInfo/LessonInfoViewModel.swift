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
    var weekDays: Observable<[Weekday]> = Observable([])
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
    func appendWeekday(tag: Int){
        guard let weekday = Weekday(rawValue: tag) else { return }
        if weekDays.value.contains(weekday) {
            weekDays.value.removeAll(where: {
                $0 == weekday
            })
        } else {
            weekDays.value.append(weekday)
        }
    }
}
