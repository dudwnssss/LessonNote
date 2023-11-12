//
//  LessonViewModel.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/11.
//

import Foundation
import RxCocoa
import RxSwift

final class LessonViewModel: ViewModel {
    
    struct Input {
        let lessonState: ControlProperty<LessonState>
        let assignmentState: ControlProperty<AssignmentState>
        let feedback: ControlProperty<String>
        let tapCompleteButton: ControlEvent<Void>
    }
    var date = Date()
    var student: Student?

    struct Output {
        let lessonState: ControlProperty<LessonState>
        let assignmentState: ControlProperty<AssignmentState>
        let feedback: ControlProperty<String>
        let validation: Observable<Bool>
        let upsert: PublishRelay<Void>
    }
    
    var disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        return Output(lessonState: input.lessonState, assignm/Users/youngjun/LessonNoteentState: input.assignmentState, feedback: input.feedback, validation: Observable.just(false), upsert: PublishRelay())
    }
    
    
    private let repository = StudentRepository()
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
