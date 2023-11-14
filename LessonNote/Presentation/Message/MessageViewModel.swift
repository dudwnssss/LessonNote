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
    var selectedDates: [Date]?
    let disposeBag = DisposeBag()
    
    struct Input {
        let messageTitle: ControlProperty<String?>
        let messageComment: ControlProperty<String?>
        let assginmentButtonTap: ControlEvent<Void>
        let selectedDates: Observable<[Date]>
        let nextButtonTap: ControlEvent<Void>
    }
    
    struct Output {
        let messageTitle: Driver<String?>
        let messageComment: Driver<String?>
        let isValid: Driver<Bool>
        let showAssignment: Driver<Bool>
    }
    
    func transform(input: Input) -> Output {
    
            
       
    }
    

    
    var selectedDates: CustomObservable<[Date]> = CustomObservable([])
    var showAssignment: CustomObservable<Bool> = CustomObservable(false)
    var title: CustomObservable<String> = CustomObservable("")
    
    let comment = BehaviorRelay<String?>(value: nil)
    var message: String?
    var isValid: CustomObservable<Bool> = CustomObservable(false)
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
        if title.value.isEmpty && selectedDates.value.isEmpty && ( comment == nil || comment.value == "") {
            message = "추가된 내용이 없습니다"
            isValid.value = false
        }
        message = nil
        isValid.value = true
    }
}
