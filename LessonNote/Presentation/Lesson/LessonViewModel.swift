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
    
    var date = Date()
    var student: Student?
    private let repository = StudentRepository()

    struct Input {
        let lessonState: BehaviorRelay<Int?>
        let assignmentState: BehaviorRelay<Int?>
        let feedback: BehaviorRelay<String?>
        let tapCompleteButton: ControlEvent<Void>
    }

    struct Output {
        let lessonState: Driver<Int?>
        let assignmentState: Driver<Int?>
        let feedback: Driver<String?>
        let validation: Observable<Bool>
        let upsert: PublishRelay<Void>
    }
    
    let upsert = PublishRelay<Void>()
    
    func transform(input: Input, disposeBag: DisposeBag) -> Output {
        
        if let student {
            for item in student.lessons{
                if date == item.date{
                    if let state = item.lessonState {
                        input.lessonState.accept(state)
                    }
                    if let state = item.assignmentState {
                        input.assignmentState.accept(state)
                    }
                    if let text = item.feedback {
                        input.feedback.accept(text)
                    }
                }
            }
        }
        
        let validation = input.lessonState.map { $0 != nil }
        input.tapCompleteButton
            .withLatestFrom(input.feedback)
            .bind(with: self) { owner, feedback in
                owner.upsertLesson(lessonState: input.lessonState.value,
                                   assignmentState: input.assignmentState.value,
                                   feedback: feedback)
            }
            .disposed(by: disposeBag)
        
        return Output(lessonState: input.lessonState.asDriver(),
                      assignmentState: input.assignmentState.asDriver(), feedback: input.feedback.asDriver(),
                      validation: validation,
                      upsert: upsert)
    }
}

extension LessonViewModel{
    
    func upsertLesson(lessonState: Int?, assignmentState: Int?, feedback: String?){
        let lesson = Lesson(date: date, lessonState: lessonState, assignmentState: assignmentState, feedback: feedback)
        if let student{
            repository.upsertLesson(student: student, lesson: lesson)
            upsert.accept(())
        }
    }
}
