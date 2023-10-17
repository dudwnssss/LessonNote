//
//  StudentEditViewModel.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/17.
//

import Foundation

final class StudentEditViewModel {
    var student: Observable<Student?> = Observable(nil)
    
    //studentInfo
    var name: Observable<String?> = Observable(nil)
    var studentIcon: Observable<StudentIcon?> = Observable(.pink)
    var studentPhoneNumber: Observable<String?>  = Observable(nil)
    var parentPhoneNumber: Observable<String?>  = Observable(nil)
    
    //lessonInfo
    var lessonTimeList: Observable<[LessonTime]> = Observable([])
    var isChecked: Observable<Bool> = Observable(false)
    var weekCount: Observable<Int> = Observable(2)
    
    //startDate
    var date: Observable<Date?> = Observable(nil)
    var weekday: Observable<Weekday> = Observable(.monday)
    var weekdays: [Weekday] = []
}

extension StudentEditViewModel {
    func setStudent(){
        guard let student = student.value else {return}
        name.value = student.studentName
        studentIcon.value = StudentIcon(rawValue: student.studentIcon)
        studentPhoneNumber.value = student.studentPhoneNumber
        parentPhoneNumber.value = student.parentPhoneNumber
    }
}
