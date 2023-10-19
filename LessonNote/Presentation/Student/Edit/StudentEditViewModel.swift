//
//  StudentEditViewModel.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/17.
//

import Foundation

final class StudentEditViewModel {
    
    var repository = StudentRepository()
    var student: Observable<Student?> = Observable(nil)
    
    //studentInfo
    var name: Observable<String> = Observable("")
    var studentIcon: Observable<StudentIcon> = Observable(.pink)
    var studentPhoneNumber: Observable<String?>  = Observable(nil)
    var parentPhoneNumber: Observable<String?>  = Observable(nil)
    
    //lessonInfo
    var lessonTimeList: Observable<[LessonTime]> = Observable([])
    var isChecked: Observable<Bool> = Observable(false)
    var weekCount: Observable<Int> = Observable(2)
    
    //startDate
    var startDate: Observable<Date> = Observable(Date())
    var weekday: Observable<Weekday> = Observable(.monday)
    var weekdays: Observable<[Weekday]> = Observable([])
}

extension StudentEditViewModel {
    func setStudent(){
        guard let student = student.value,
              let studentIcon = StudentIcon(rawValue: student.studentIcon),
              let startDate = student.lessonStartDate  else {return}
        name.value = student.studentName
        self.studentIcon.value = studentIcon
        studentPhoneNumber.value = student.studentPhoneNumber
        parentPhoneNumber.value = student.parentPhoneNumber
        lessonTimeList.value = student.lessonSchedules.map{$0.toLessonTime()}
        isChecked.value = student.weekCount > 1
        weekCount.value = student.weekCount
        self.startDate.value = startDate
        weekdays.value = lessonTimeList.value.map{$0.weekday}
        weekday.value = Weekday(rawValue: student.startWeekday)!
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
    
    func setInitialWeekdays(){
        weekdays.value = lessonTimeList.value.map{$0.weekday}
        weekday.value = weekdays.value.first ?? .monday
    }
    
    func update(){
        guard let student = student.value else { return }
        repository.update(item: student, studentName: name.value, studentIcon: studentIcon.value, studentPhoneNumber: studentPhoneNumber.value, parentPhoneNumber: parentPhoneNumber.value, lessonTimes: lessonTimeList.value, weekCount: weekCount.value, lessonStartDate: startDate.value, startWeekday: weekday.value)
    }
    
    func delete(){
        guard let student = student.value else {return}
        repository.delete(student)
    }
    
}
