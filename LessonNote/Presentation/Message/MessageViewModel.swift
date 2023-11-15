//
//  MessageViewModel.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/15.
//

import Foundation
import RxSwift
import RxCocoa

class MessageViewModel: ViewModel {
    
    var personType: PersonType = .student
    var student: Student?
    
    struct Input {
        let messageTitle: ControlProperty<String?>
        let messageComment: ControlProperty<String?>
        let assginmentButtonTap: ControlEvent<Void>
        let selectedDates: Observable<[Date]>
        let nextButtonTap: ControlEvent<Void>
    }
    
    struct Output {
        let messageTitle = PublishRelay<String?>()
        let messageComment = PublishRelay<String?>()
        let isValid = PublishRelay<Bool>()
        let showAssignment = BehaviorRelay<Bool>(value: false)
        let navToNext = PublishRelay<LessonMessage>()
    }
    
    func transform(input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        
        let validation = Observable.combineLatest(input.messageTitle.asObservable(), input.messageComment.asObservable(), input.selectedDates)
            .map { title, comment, dates in
                !(title == "" && dates.isEmpty && comment == Const.commentPlaceholder)
            }
            .debug()
        
        let messageObservable = Observable.combineLatest(input.messageTitle.asObservable(), input.messageComment.asObservable(), input.selectedDates)
        
        
        input.nextButtonTap
            .withLatestFrom(validation)
            .bind(with: self) { owner, value in
                if value {
                    output.navToNext.accept(<#T##event: LessonMessage##LessonMessage#>)
                }
            }
            .disposed(by: disposeBag)
        
        input.assginmentButtonTap
            .bind(with: self) { owner, _ in
                let value = !output.showAssignment.value
                output.showAssignment.accept(value)
            }
            .disposed(by: disposeBag)
        
        return output
    }
}
