//
//  MessagePreviewViewModel.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/15.
//

import Foundation

class MessagePreviewViewModel {
    let student: Student
    let lessonMessage: LessonMessage
    
    init(student: Student, lessonMessage: LessonMessage) {
        self.student = student
        self.lessonMessage = lessonMessage
    }
}
