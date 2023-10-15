//
//  MessageVIewController.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/15.
//

import UIKit

class MessageViewController: BaseViewController {
    
    private let messageView = MessageView()
    let messageViewModel = MessageViewModel()
    override func loadView() {
        self.view = messageView
    }
    override func setProperties() {
        guard let student = messageViewModel.student else {return}
        messageView.configureView(student: student, type: messageViewModel.personType)
    }
    
    
}
