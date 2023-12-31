//
//  StudentInfoViewModel.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/05.
//

import Foundation
import RxSwift
import RxCocoa

final class StudentInfoViewModel{
    
    var isValid: CustomObservable<Bool> = CustomObservable(false)
    
    
    var name: CustomObservable<String> = CustomObservable("")
    
    
    
    var studentIcon: CustomObservable<StudentIcon?> = CustomObservable(.pink)
    var studentPhoneNumber: CustomObservable<String?>  = CustomObservable(nil)
    var parentPhoneNumber: CustomObservable<String?>  = CustomObservable(nil)
    var message: String?
  
    
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
        message = nil
        isValid.value = true
    }
    
    func storeData(){
        TempStudent.shared.studentName = name.value
        TempStudent.shared.studentIcon = studentIcon.value
        TempStudent.shared.studentPhoneNumber = studentPhoneNumber.value
        TempStudent.shared.parentPhoneNumber = parentPhoneNumber.value
    }
    
    

}
