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
        let messageTitle: Observable<String?>
        let messageComment: Observable<String?>
        let assginmentButtonTap: Observable<Void>
        let selectedDates: Observable<[Date]>
        let nextButtonTap: Observable<Void>
    }
    
    struct Output {
        let messageTitle = PublishRelay<String?>()
        let messageComment = BehaviorRelay<String?>(value: nil)
        let isValid = PublishRelay<Bool>()
        let showAssignment = BehaviorRelay<Bool>(value: false)
        let navToNext = PublishRelay<LessonMessage>()
    }
    
    func transform(input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        
        input.messageTitle
            .bind(to: output.messageTitle)
            .disposed(by: disposeBag)
        
        input.messageComment
            .bind(to: output.messageComment)
            .disposed(by: disposeBag)
        
        let validation = Observable.combineLatest(input.messageTitle.asObservable(), input.messageComment.asObservable(), input.selectedDates)
            .map { title, comment, dates in
                !(title == "" && dates.isEmpty && comment == Const.commentPlaceholder)
            }
        
        validation
            .bind(to: output.isValid)
            .disposed(by: disposeBag)
        
        input.assginmentButtonTap
            .bind(with: self) { owner, _ in
                let value = !output.showAssignment.value
                output.showAssignment.accept(value)
            }
            .disposed(by: disposeBag)
                
        input.nextButtonTap
            .withLatestFrom(validation)
            .filter { $0 }
            .withLatestFrom(Observable.combineLatest(input.messageTitle, input.messageComment, input.selectedDates))
               .map { title, comment, dates in
                   return LessonMessage(
                       title: title,
                       dates: dates,
                       comment: comment,
                       assignment: output.showAssignment.value,
                       personType: self.personType
                   )
               }
               .bind(to: output.navToNext)
               .disposed(by: disposeBag)
        
        return output
    }
}

