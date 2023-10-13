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

    init(student: Student){
        self.student.value = student
        bind()
    }
    
    private func bind(){
        guard let student = student.value else {return}
        let weekdays = student.lessonSchedules.map { $0.weekday }
        let weekCount = student.weekCount
        let startWeekday = weekdays.first
        let startDate = student.lessonStartDate
        let weekdaysArray = Array(weekdays)

        scheduledLessonDates.value = DateManager.shared.generateYearlyLessonSchedule(weekday: weekdaysArray, weekCount: weekCount!, startWeekday: startWeekday!, startDate: startDate!)
    }
}

extension StudentViewModel{
    func updateStudent(){
        guard let studentId = student.value?.studentId else {return}
        student.value = repository.fetchStudentById(studentId)
        print(#fileID, #function, #line, "- ")
    }
}

