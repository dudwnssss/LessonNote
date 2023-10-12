//
//  StudentViewModel.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/10.
//

import Foundation

final class StudentViewModel {
    
    var scheduledLessonDates: Observable<[Date]> = Observable([]) //event 사용 studentIcon.color
    var completedLessonDates: Observable<[Date]> = Observable([]) //text 사용 studentIcon.color
    var canceledLessonDates: Observable<[Date]> = Observable([]) //text 사용 Color.gray5
    var supplementedLessonDates: Observable<[Date]> = Observable([]) //text 사용 studentIcont.color
    var student: Student?
    //보강, 휴강, 수업
    /*
     이 배열 중 하나라도 date가 추가 될 경우:
        나머지 배열에서 같은 date의 수업을 제거
        scheduledLessonDates에서도 제거
     */
    init(student: Student){
        self.student = student
        bind()
    }
    
    private func bind(){
        guard let student else {return}

        let weekdays = student.lessonSchedules.map { $0.weekday }
        let weekCount = student.weekCount
        let startWeekday = weekdays.first
        let startDate = student.lessonStartDate
        let weekdaysArray = Array(weekdays)

        
        scheduledLessonDates.value = DateManager.shared.generateYearlyLessonSchedule(weekday: weekdaysArray, weekCount: weekCount!, startWeekday: startWeekday!, startDate: startDate!)
    }
}
