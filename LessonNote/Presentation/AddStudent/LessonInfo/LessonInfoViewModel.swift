//
//  LessonInfoViewModel.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/05.
//

import Foundation

final class LessonInfoViewModel{
    
    var lessonTimeList: Observable<[LessonTime]> = Observable([])
    var isChecked: Observable<Bool> = Observable(false)
    var weekCount: Observable<Int> = Observable(1)
    var isValid: Observable<Bool> = Observable(false)
    var message: String?
}

extension LessonInfoViewModel{
    func storeData(){
        TempStudent.shared.lessonTimes = lessonTimeList.value
        TempStudent.shared.weekCount = weekCount.value
    }
    func setWeekCount(){
        if isChecked.value {
            weekCount.value = 2
        } else {
            weekCount.value = 1
        }
    }
    func sortLessonTime() {
        if lessonTimeList.value.count >= 2 {
            lessonTimeList.value.sort { lhs, rhs in
                lhs.weekday.rawValue < rhs.weekday.rawValue
            }
        }
    }
    
    func checkValidation(){
        if lessonTimeList.value.isEmpty {
            isValid.value = false
            message = "최소 한 개 이상의 수업을 등록해주세요"
            return
        }
        message = nil
        isValid.value = true
    }

}
