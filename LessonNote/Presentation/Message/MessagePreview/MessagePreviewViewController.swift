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
    private let viewModel: MessagePreviewViewModel
    
    init(viewModel: MessagePreviewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func setProperties() {
        viewModel.lessonMessage.dates.forEach { date in
            messagePreviewView.calendarView.select(date)
        }
        messagePreviewView.do {
            $0.messageTitleLabel.text = viewModel.lessonMessage.title
            $0.commentLabel.text = viewModel.lessonMessage.comment
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
            $0.height.equalTo(300 * DateManager.shared.countUniqueMonths(dates: viewModel.lessonMessage.dates))
        }
    }
    
    @objc func sendButtonDidTap(){
        sendMessage()
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        if let minDate = viewModel.lessonMessage.dates.min() {
            return minDate
        } else {
            return Date()
        }
    }
    func maximumDate(for calendar: FSCalendar) -> Date {
        if let maxDate = viewModel.lessonMessage.dates.max() {
            return maxDate
        } else {
            return Date()
        }
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
        guard let lessons = viewModel.student?.lessons else { return nil }
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
        guard let lessons = viewModel.student?.lessons else { return nil }
        for item in lessons {
            if date == item.date && viewModel.lessonMessage.dates.contains(date) {
                guard let state = item.lessonState,
                      let stateString = LessonState(rawValue: state)?.calendarTitle else { return nil}
                return stateString
            }
        }
        return nil
    }
    
    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
        if viewModel.lessonMessage.assignment {
            guard let lessons = viewModel.student?.lessons else { return nil }
            for item in lessons {
                if date == item.date && viewModel.lessonMessage.dates.contains(date) {
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
            guard let student = viewModel.student else { return }
            switch viewModel.lessonMessage.personType {
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
            
            self.present(messageComposer, animated: true)
            
            
        } else {
            print("메시지를 보낼 수 없습니다.")
        }
    }
        
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        dismiss(animated: true)
        switch result {
        case .cancelled:
            print("전송 취소")
        case .sent:
            if let viewControllers = navigationController?.viewControllers {
                    if viewControllers.count >= 3 {
                        guard let targetViewController = viewControllers[viewControllers.count - 3] as? StudentViewController else {return}
                        navigationController?.popToViewController(targetViewController, animated: true)
                        targetViewController.showToggle(text: "메시지가 전송되었습니다")
                    }
                }        case .failed:
            print("메시지 전송 실패")
        }
    }
}
