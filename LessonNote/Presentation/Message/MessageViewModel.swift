//
//  MessageViewModel.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/15.
//

import Foundation

class MessageViewModel {
    var personType: PersonType = .student
    var student: Student?
    var selectedDates: Observable<[Date]> = Observable([])
    var showAssignment: Observable<Bool> = Observable(false)
    var title: Observable<String> = Observable("")
    var comment: String? = nil
    var message: String?
    var isValid: Observable<Bool> = Observable(false)
}

extension MessageViewModel {
    func createLessonMessage() -> LessonMessage{
        let message = LessonMessage(title: title.value,
                                    dates: selectedDates.value,
                                    comment: comment,
                                    assignment: showAssignment.value, personType: personType)
        return message
    }
    
    func checkValidation(){
        if title.value.isEmpty && selectedDates.value.isEmpty && ( comment == nil || comment == "") {
            message = "추가된 내용이 없습니다"
            isValid.value = false
        }
        message = nil
        isValid.value = true
    }
}
