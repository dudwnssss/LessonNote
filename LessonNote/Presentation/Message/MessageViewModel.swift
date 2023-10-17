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
    var selectedDates: [Date] = []
    var showAssignment: Observable<Bool> = Observable(false)
    var title: Observable<String> = Observable("")
    var comment: String? = nil
}

extension MessageViewModel {
    func createLessonMessage() -> LessonMessage{
        let message = LessonMessage(title: title.value,
                                    dates: selectedDates,
                                    comment: comment,
                                    assignment: showAssignment.value, personType: personType)
        return message
    }
}
