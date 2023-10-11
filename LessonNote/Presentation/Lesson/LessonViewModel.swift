//
//  LessonViewModel.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/11.
//

import Foundation

final class LessonViewModel {
    
    var date = Date()
    var student: Student?
    
    var selectedLessonState: Observable<LessonState?> = Observable(nil)
    var selectedAssignmentState: Observable<AssignmentState?> = Observable(nil)
    var memo: Observable<String?> = Observable(nil)
    
    func bind(){
        
    }
    
}

extension LessonViewModel{
    
//    func appendLesson(){
//        let lesson = Lesson(date: date, lessonState: selectedLessonState.value?.rawValue, assignmentState: selectedAssignmentState.value?.rawValue, feedback: memo.value)
//        student?.lessons.append(lesson)
//    }
    
}
