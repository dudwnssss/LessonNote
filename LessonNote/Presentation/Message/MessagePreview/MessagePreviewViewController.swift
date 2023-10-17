//
//  MessagePreviewViewController.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/15.
//

import UIKit
import FSCalendar
import MessageUI


class MessagePreviewViewController: BaseViewController {
    
    private let messagePreviewView = MessagePreviewView()
    let messagePreviewViewModel = MessagePreviewViewModel()
    
    override func setProperties() {
        messagePreviewViewModel.lessonMessage.dates.forEach { date in
            messagePreviewView.calendarView.select(date)
        }
        messagePreviewView.do {
            $0.messageTitleLabel.text = messagePreviewViewModel.lessonMessage.title
            $0.commentLabel.text = messagePreviewViewModel.lessonMessage.comment
            $0.calendarView.dataSource = self
            $0.calendarView.delegate = self
            $0.sendButton.addTarget(self, action: #selector(sendButtonDidTap), for: .touchUpInside)
        }
        
    }
    
    override func loadView() {
        self.view = messagePreviewView
    }
    
    override func setNavigationBar() {
        navigationItem.title = "수업 문자 보내기"
    }
    func render() -> UIImage {
        let viewToRender = messagePreviewView.verticalStackView
        let renderer = UIGraphicsImageRenderer(size: viewToRender.bounds.size)
        let image = renderer.image { context in
            viewToRender.drawHierarchy(in: viewToRender.bounds, afterScreenUpdates: true)
        }
        return image
    }
    
    
    
    override func setLayouts() {
        messagePreviewView.calendarView.snp.makeConstraints {
            $0.height.equalTo(300 * DateManager.shared.countUniqueMonths(dates: messagePreviewViewModel.lessonMessage.dates))
        }
    }
    
    @objc func sendButtonDidTap(){
        sendMessage()
    }
}

extension MessagePreviewViewController: FSCalendarDataSource, FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendar.snp.updateConstraints { (make) in
            make.height.equalTo(bounds.height)
        }
        self.view.layoutIfNeeded()
    }
    func minimumDate(for calendar: FSCalendar) -> Date {
        if let minDate = messagePreviewViewModel.lessonMessage.dates.min() {
            return minDate
        } else {
            return Date()
        }
    }
    func maximumDate(for calendar: FSCalendar) -> Date {
        if let maxDate = messagePreviewViewModel.lessonMessage.dates.max() {
            return maxDate
        } else {
            return Date()
        }
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
        guard let lessons = messagePreviewViewModel.student?.lessons else { return nil }
        for item in lessons {
            if date == item.date{
                guard let stateRawValue = item.lessonState, let state = LessonState(rawValue: stateRawValue) else {return nil}
                switch state {
                case .canceled:
                    return Color.gray4
                default:
                    return Color.black
                }
            }
        }
        return nil
    }
    
    
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        guard let lessons = messagePreviewViewModel.student?.lessons else { return nil }
        for item in lessons {
            if date == item.date && messagePreviewViewModel.lessonMessage.dates.contains(date) {
                guard let state = item.lessonState,
                      let stateString = LessonState(rawValue: state)?.calendarTitle else { return nil}
                return stateString
            }
        }
        return nil
    }
    
    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
        if messagePreviewViewModel.lessonMessage.assignment {
            guard let lessons = messagePreviewViewModel.student?.lessons else { return nil }
            for item in lessons {
                if date == item.date && messagePreviewViewModel.lessonMessage.dates.contains(date) {
                    guard let stateRawValue = item.assignmentState, let state = AssignmentState(rawValue: stateRawValue) else {return nil}
                    return state.image
                }
            }
            return nil
        } else {
            return nil
        }
    }
}

extension MessagePreviewViewController: MFMessageComposeViewControllerDelegate {
    
    func sendMessage(){
        if MFMessageComposeViewController.canSendText() {
            let messageComposer = MFMessageComposeViewController()
            messageComposer.messageComposeDelegate = self
            
            var phoneNumber = ""
            guard let student = messagePreviewViewModel.student else { return }
            switch messagePreviewViewModel.lessonMessage.personType {
            case .student:
                guard let studentPhoneNumber = student.studentPhoneNumber else { return }
                phoneNumber = studentPhoneNumber
            case .parent:
                guard let parentPhoneNumber = student.parentPhoneNumber else { return }
                phoneNumber = parentPhoneNumber
            }
            messageComposer.recipients = [phoneNumber]
            messageComposer.body = nil
            
            if let imageData = render().pngData() {
                messageComposer.addAttachmentData(imageData, typeIdentifier: "lesson.data", filename: "attachment.png")
            }
            
            self.present(messageComposer, animated: true, completion: nil)
        } else {
            print("메시지를 보낼 수 없습니다.")
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        dismiss(animated: true)
    }
}