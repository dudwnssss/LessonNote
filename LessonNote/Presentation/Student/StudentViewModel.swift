//
//  StudentViewModel.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/10.
//

import Foundation

final class StudentViewModel {
    
    private let repository = StudentRepository()
    var scheduledLessonDates: Observable<[Date]> = Observable([]) //event 사용
    var student: Observable<Student?> = Observable(nil)
}

extension StudentViewModel{
    
    func setSchedule(student: Student){
        print(#fileID, #function, #line, "- ")
        let weekdays = student.lessonSchedules.map { $0.weekday }
        let weekCount = student.weekCount
        let startWeekday = student.startWeekday
        let startDate = student.lessonStartDate
        let weekdaysArray = Array(weekdays)
        let dates = DateManager.shared.generateYearlyLessonSchedule(weekday: weekdaysArray, weekCount: weekCount, startWeekday: startWeekday, startDate: startDate!)
        scheduledLessonDates.value = dates
        print(DateManager.shared.generateWeeksArray(from: dates))
    }
    
    func updateStudent(){
        guard let studentId = student.value?.studentId else {return}
        student.value = repository.fetchStudentById(studentId)
    }
    


    
}

