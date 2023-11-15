//
//  MessageViewController.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/15.
//

import UIKit
import FSCalendar
import RxSwift
import RxCocoa
import Toast


class MessageViewController: BaseViewController {
    
    private let messageView = MessageView()
    let viewModel = MessageViewModel()
    let selectedDates = BehaviorRelay<[Date]>(value: [])
    let showAssignment = BehaviorRelay<Bool>(value: false)
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = messageView
    }
    override func setProperties() {
        guard let student = viewModel.student else {return}
        
        messageView.do {
            $0.configureView(student: student, type: viewModel.personType)
            $0.calendarView.delegate = self
            $0.calendarView.dataSource = self
        }
    }
    
    override func setNavigationBar() {
        navigationItem.title = "수업 문자 보내기"
    }
    
    override func bind() {
        let input = MessageViewModel.Input(messageTitle: messageView.messageTitleTextField.textField.rx.text.asObservable(), messageComment: messageView.commentTextView.textView.rx.text.asObservable(), assginmentButtonTap: messageView.assignmentButton.rx.tap.asObservable(), selectedDates: selectedDates.asObservable(), nextButtonTap: messageView.nextButton.rx.tap.asObservable())
        
        let output = viewModel.transform(input: input, disposeBag: disposeBag)
        
        output.isValid
            .asDriver(onErrorJustReturn: false)
            .drive(with: self) { owner, value in
                owner.messageView.nextButton.configureButton(isValid: value)
            }
            .disposed(by: disposeBag)
        output.messageComment
            .asDriver(onErrorJustReturn: nil)
            .drive(with: self) { owner, _ in
                owner.messageView.commentTextView.setPlaceholderColor()
            }
            .disposed(by: DisposeBag())
        output.showAssignment
            .bind(with: self) { owner, value in
                owner.messageView.configureButton(isSelected: value)
                owner.showAssignment.accept(value)
                owner.messageView.calendarView.reloadData()
            }
            .disposed(by: disposeBag)
        output.navToNext
            .bind(with: self) { owner, message in
                owner.pushToMessagePreviewVC(message: message)
            }
            .disposed(by: disposeBag)
    }
}

extension MessageViewController: FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let dates = messageView.calendarView.selectedDates
        selectedDates.accept(dates)
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let dates = messageView.calendarView.selectedDates
        selectedDates.accept(dates)
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendar.snp.updateConstraints { (make) in
            make.height.equalTo(bounds.height)
        }
        self.view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
        guard let icon = viewModel.student?.studentIcon, let color = StudentIcon(rawValue: icon)?.textColor else { return nil }
        return color
    }
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        guard let student = viewModel.student, let startDate = student.lessonStartDate else {
            return Date()
        }
        return startDate
    }
    
    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
        if showAssignment.value {
            guard let lessons = viewModel.student?.lessons else { return nil }
            for item in lessons {
                if date == item.date{
                    guard let stateRawValue = item.assignmentState, let state = AssignmentState(rawValue: stateRawValue) else {return nil}
                    return state.image
                }
            }
            return nil
        } else {
            return nil
        }
    }
    


func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
    guard let lessons = viewModel.student?.lessons else { return nil }
    for item in lessons {
        if date == item.date{
            guard let state = item.lessonState,
                  let stateString = LessonState(rawValue: state)?.calendarTitle else { return nil}
            return stateString
        }
    }
    return nil
}

func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, subtitleDefaultColorFor date: Date) -> UIColor? {
    guard let lessons = viewModel.student?.lessons else { return nil }
    for item in lessons {
        if date == item.date{
            guard let stateRawValue = item.lessonState, let state = LessonState(rawValue: stateRawValue) else {return nil}
            switch state {
            case .completed, .supplemented:
                guard let icon = viewModel.student?.studentIcon, let color = StudentIcon(rawValue: icon)?.textColor else {return nil}
                return color
                
            case .canceled, .none:
                return Color.gray4
            }
        }
    }
    return nil
}

func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, subtitleSelectionColorFor date: Date) -> UIColor? {
    guard let lessons = viewModel.student?.lessons else { return nil }
    for item in lessons {
        if date == item.date{
            guard let stateRawValue = item.lessonState, let state = LessonState(rawValue: stateRawValue) else {return nil}
            switch state {
            case .completed, .supplemented:
                return Color.white
                
            case .canceled, .none:
                return Color.gray0
            }
        }
    }
    return nil
}

}

extension MessageViewController {
    private func pushToMessagePreviewVC(message: LessonMessage){
        let vm = MessagePreviewViewModel()
        vm.student = viewModel.student
        vm.lessonMessage = message
        let vc = MessagePreviewViewController(viewModel: vm)
        navigationController?.pushViewController(vc, animated: true)
    }
}
