//
//  StudentEditViewModel.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/17.
//

import Foundation

final class StudentEditViewModel {
    
    var repository = StudentRepository()
    var student: CustomObservable<Student?> = CustomObservable(nil)
    
    //studentInfo
    var name: CustomObservable<String> = CustomObservable("")
    var studentIcon: CustomObservable<StudentIcon> = CustomObservable(.pink)
    var studentPhoneNumber: CustomObservable<String?>  = CustomObservable(nil)
    var parentPhoneNumber: CustomObservable<String?>  = CustomObservable(nil)
    
    //lessonInfo
    var lessonTimeList: CustomObservable<[LessonTime]> = CustomObservable([])
    var isChecked: CustomObservable<Bool> = CustomObservable(false)
    var weekCount: CustomObservable<Int> = CustomObservable(2)
    
    //startDate
    var startDate: CustomObservable<Date> = CustomObservable(DateManager.shared.getYearAgoDate())
    var weekday: CustomObservable<Weekday> = CustomObservable(.monday)
    var weekdays: CustomObservable<[Weekday]> = CustomObservable([])
    var isValid: CustomObservable<Bool> = CustomObservable(false)
    var message: String?
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
        weekdays.value = lessonTimeList.value.map{ $0.weekday }
        if weekdays.value.contains(weekday.value) { return }
        weekday.value = weekdays.value.first ?? .monday
    }
    
    func update(){
        guard let student = student.value else { return }
        repository.update(item: student,
                          studentName: name.value, studentIcon: studentIcon.value,
                          studentPhoneNumber: studentPhoneNumber.value,
                          parentPhoneNumber: parentPhoneNumber.value,
                          lessonTimes: lessonTimeList.value,
                          weekCount: weekCount.value,
                          lessonStartDate: startDate.value,
                          startWeekday: weekday.value)
    }
    
    func delete(){
        guard let student = student.value else {return}
        repository.delete(student)
    }
    
    func checkValidation(){
        if name.value.isEmpty {
            isValid.value = false
            message = "학생 이름을 입력해주세요"
            return
        }
        
        if studentPhoneNumber.value == nil || studentPhoneNumber.value == ""{
            isValid.value = true
        } else {
            guard let phoneNumber = studentPhoneNumber.value else {return}
            switch phoneNumber.validatePhone() {
            case true:
                isValid.value = true
            case false:
                isValid.value = false
                message = "전화번호 형식이 올바르지 않습니다"
                return
            }
        }
        
        if parentPhoneNumber.value == nil || parentPhoneNumber.value == ""{
            isValid.value = true
        } else {
            guard let phoneNumber = parentPhoneNumber.value else {return}
            switch phoneNumber.validatePhone() {
            case true:
                isValid.value = true
            case false:
                isValid.value = false
                message = "전화번호 형식이 올바르지 않습니다"
                return
            }
        }
        
        if lessonTimeList.value.isEmpty {
            isValid.value = false
            message = "최소 한 개 이상의 수업을 등록해주세요"
            return
        }
        
        message = nil
        isValid.value = true
    }
    
}
