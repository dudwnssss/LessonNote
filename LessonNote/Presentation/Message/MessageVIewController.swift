//
//  MessageViewController.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/15.
//

import UIKit
import FSCalendar
import Toast

class MessageViewController: BaseViewController {
    
    private let messageView = MessageView()
    let messageViewModel = MessageViewModel()
    override func loadView() {
        self.view = messageView
    }
    override func setProperties() {
        guard let student = messageViewModel.student else {return}
       
        messageView.do {
            $0.configureView(student: student, type: messageViewModel.personType)
            $0.calendarView.delegate = self
            $0.calendarView.dataSource = self
            $0.assignmentButton.addTarget(self, action: #selector(assignmentButtonDidTap), for: .touchUpInside)
            $0.nextButton.addTarget(self, action: #selector(nextButtonDidTap), for: .touchUpInside)
            $0.messageTitleTextField.textField.addTarget(self, action: #selector(titleTextFieldDidChange), for: .editingChanged)
        }
    }
    
    override func setNavigationBar() {
        navigationItem.title = "수업 문자 보내기"
    }
    
    override func bind() {
        messageViewModel.showAssignment.bind { value in
            self.messageView.configureButton(isSelected: value)
            self.messageView.calendarView.reloadData()
        }
        messageViewModel.title.bind { text in
            self.messageView.messageTitleTextField.textField.text = text
            self.messageViewModel.checkValidation()
        }
        messageViewModel.isValid.bind { [weak self] value in
            self?.messageView.nextButton.configureButton(isValid: value)
        }
    }
    
    @objc func assignmentButtonDidTap(){
        messageViewModel.showAssignment.value.toggle()
    }
    @objc func titleTextFieldDidChange(){
        messageViewModel.title.value = messageView.messageTitleTextField.textField.text ?? ""
    }
    
    @objc func nextButtonDidTap(){
        messageViewModel.selectedDates.value = messageView.calendarView.selectedDates
        if messageView.commentTextView.textView.text == messageView.commentTextView.placeholder {
            messageViewModel.comment = nil
        } else {
            messageViewModel.comment = messageView.commentTextView.textView.text
        }
        
        let vc = MessagePreviewViewController()
        vc.messagePreviewViewModel.student = messageViewModel.student
        vc.messagePreviewViewModel.lessonMessage = messageViewModel.createLessonMessage()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension MessageViewController: FSCalendarDataSource, FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendar.snp.updateConstraints { (make) in
            make.height.equalTo(bounds.height)
        }
        self.view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
        guard let icon = messageViewModel.student?.studentIcon, let color = StudentIcon(rawValue: icon)?.textColor else { return nil }
        return color
    }
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        guard let student = messageViewModel.student, let startDate = student.lessonStartDate else {
            return Date()
        }
        return startDate
    }
    
    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
        if messageViewModel.showAssignment.value {
            guard let lessons = messageViewModel.student?.lessons else { return nil }
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
        guard let lessons = messageViewModel.student?.lessons else { return nil }
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
        guard let lessons = messageViewModel.student?.lessons else { return nil }
        for item in lessons {
            if date == item.date{
                guard let stateRawValue = item.lessonState, let state = LessonState(rawValue: stateRawValue) else {return nil}
                switch state {
                case .completed, .supplemented:
                    guard let icon = messageViewModel.student?.studentIcon, let color = StudentIcon(rawValue: icon)?.textColor else {return nil}
                    return color
                    
                case .canceled, .none:
                    return Color.gray4
                }
            }
        }
        return nil
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, subtitleSelectionColorFor date: Date) -> UIColor? {
        guard let lessons = messageViewModel.student?.lessons else { return nil }
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
