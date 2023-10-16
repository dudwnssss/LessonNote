//
//  MessagePreviewViewController.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/15.
//

import UIKit
import FSCalendar
import MessageUI


class MessagePreviewViewController: BaseViewController, MFMessageComposeViewControllerDelegate {
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        navigationController?.popViewController(animated: true)
    }
    
    
    private let messagePreviewView = MessagePreviewView()
    let messagePreviewViewModel = MessagePreviewViewModel()
    
    override func setProperties() {
        messagePreviewView.calendarView.dataSource = self
        messagePreviewView.calendarView.delegate = self
        messagePreviewView.sendButton.addTarget(self, action: #selector(sendButtonDidTap), for: .touchUpInside)
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
    
    func sendMessage(){
        if MFMessageComposeViewController.canSendText() {
            let messageComposer = MFMessageComposeViewController()
            messageComposer.messageComposeDelegate = self
            messageComposer.recipients = ["+1234567890"] // 전화번호를 미리 설정, 국제 전화번호 형식 사용
            
            messageComposer.body = nil // 메시지 본문
            
            if let imageData = render().pngData() {
                messageComposer.addAttachmentData(imageData, typeIdentifier: "public.data", filename: "attachment.png")
            }
            
            self.present(messageComposer, animated: true, completion: nil)
        } else {
            // 문자 메시지를 보낼 수 없는 경우에 대한 처리
        }
        
    }
    
    override func setLayouts() {
        messagePreviewView.calendarView.snp.makeConstraints {
            $0.height.equalTo(300 * DateManager.shared.countUniqueMonths(dates: messagePreviewViewModel.dateList))
        }
    }
    
    @objc func sendButtonDidTap(){
        sendMessage()
    }
}

extension MessagePreviewViewController: FSCalendarDataSource, FSCalendarDelegateAppearance {
    func minimumDate(for calendar: FSCalendar) -> Date {
        if let minDate = messagePreviewViewModel.dateList.min() {
            return minDate
        } else {
            return Date()
        }
    }
    func maximumDate(for calendar: FSCalendar) -> Date {
        if let maxDate = messagePreviewViewModel.dateList.max() {
            return maxDate
        } else {
            return Date()
        }
    }
}
