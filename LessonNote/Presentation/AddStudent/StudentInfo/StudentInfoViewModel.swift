//
//  StudentInfoViewModel.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/05.
//

import Foundation

final class StudentInfoViewModel{
    
    var isValid: Observable<Bool> = Observable(false)
    var name: Observable<String?> = Observable(nil)
    var studentIcon: Observable<StudentIcon?> = Observable(.pink)
    var studentPhoneNumber: Observable<String?>  = Observable(nil)
    var parentPhoneNumber: Observable<String?>  = Observable(nil)
  
    
    func checkValidation(){
        guard let name = name.value else {
            print("이름 공백")
            isValid.value = false
            return
        }
        guard let studentPhoneNumber = studentPhoneNumber.value else {
            print("학생 전화번호 공백")
            isValid.value = false
            return
        }
        guard let parentPhoneNumber = parentPhoneNumber.value else {
            print("학부모 전화번호 공백")
            isValid.value = false
            return
        }
        isValid.value = true
    }
    
    func storeData(){
        TempStudent.shared.studentName = name.value
        TempStudent.shared.studentIcon = studentIcon.value
        TempStudent.shared.studentPhoneNumber = studentPhoneNumber.value
        TempStudent.shared.parentPhoneNumber = parentPhoneNumber.value
    }
}
