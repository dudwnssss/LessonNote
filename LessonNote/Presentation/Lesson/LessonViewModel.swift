//
//  LessonViewModel.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/11.
//

import Foundation

final class LessonViewModel {
    
    private let repository = StudentRepository()
    var date = Date()
    var student: Student?
    
    var lessonState: CustomObservable<LessonState?> = CustomObservable(nil)
    var assignmentState: CustomObservable<AssignmentState?> = CustomObservable(nil)
    var feedback: CustomObservable<String?> = CustomObservable(nil)
    var isValid: CustomObservable<Bool> = CustomObservable(true)
    
}

extension LessonViewModel{
    
    func loadState(){
        if let student {
            for item in student.lessons{
                if date == item.date{
                    if let state = item.lessonState {
                        lessonState.value = LessonState(rawValue: state)
                    }
                    if let state = item.assignmentState{
                        assignmentState.value = AssignmentState(rawValue: state)
                    }
                    feedback.value = item.feedback
                }
            }
        }
    }
    
    func upsertLesson(){
        let lesson = Lesson(date: date, lessonState: lessonState.value?.rawValue, assignmentState: assignmentState.value?.rawValue, feedback: feedback.value)
        if let student{
            repository.upsertLesson(student: student, lesson: lesson)
        }
    }
}
