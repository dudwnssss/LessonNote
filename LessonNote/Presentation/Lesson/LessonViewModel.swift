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
        let lessonState: BehaviorRelay<Int?>
        let assignmentState: BehaviorRelay<Int?>
        let feedback: ControlProperty<String?>
        let tapCompleteButton: ControlEvent<Void>
    }
    
    var date = Date()
    var student: Student?

    struct Output {
        let lessonState: BehaviorRelay<Int?>
        let assignmentState: BehaviorRelay<Int?>
        let feedback: ControlProperty<String?>
        let validation: Observable<Bool>
        let upsert: PublishRelay<Void>
    }
    
    var disposeBag = DisposeBag()
    
    // Middle
    private let oldTag = BehaviorRelay<Int?>(value: nil)

    func transform(input: Input) -> Output {
        
//        input.assignmentState.bind(with: self) { owner, value in
//            owner.oldTag.accept(value)
//        }
//        .disposed(by: disposeBag)
        
 
                
        return Output(lessonState: input.lessonState, assignmentState: input.assignmentState, feedback: input.feedback, validation: Observable.just(false), upsert: PublishRelay())
    }
    
    
    private let repository = StudentRepository()
    var lessonState: CustomObservable<LessonState?> = CustomObservable(nil)
    var assignmentState: CustomObservable<AssignmentState?> = CustomObservable(nil)
    var feedback: CustomObservable<String?> = CustomObservable(nil)
    var isValid: CustomObservable<Bool> = CustomObservable(true)
    
}

extension LessonViewModel{
    
    func loadState(lessonState: BehaviorRelay<Int?>, assignmentState: BehaviorRelay<Int?>, feedback: ControlProperty<String?>){
        
        if let student {
            for item in student.lessons{
                if date == item.date{
                    if let state = item.lessonState {
                        lessonState.accept(state)
                    }
                    if let state = item.assignmentState{
                        assignmentState.accept(state)
                    }
//                    feedback = ControlProperty<String?>.just("")
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
