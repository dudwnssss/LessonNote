//
//  LessonViewController.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/11.
//

import UIKit

final class LessonViewController: BaseViewController {    
    
    private let lessonView = LessonView()
    private let lessonViewModel = LessonViewModel()
    
    override func loadView() {
        self.view = lessonView
    }
    
    override func setProperties() {
        hideKeyboardWhenTappedAround()
        lessonView.LessonButtons.forEach {
            $0.addTarget(self, action: #selector(lessonButtonDidTap(sender:)), for: .touchUpInside)
        }
        lessonView.AssignmentButtons.forEach {
            $0.addTarget(self, action: #selector(AssignmentButtonDidTap(sender:)), for: .touchUpInside)
        }
        
    }
    
    @objc func lessonButtonDidTap(sender: CustomButton){
        lessonView.LessonButtons.forEach {
            $0.isActivated = false
        }
        sender.isActivated = true
    }
    @objc func AssignmentButtonDidTap(sender: CustomButton){
        lessonView.AssignmentButtons.forEach {
            $0.isActivated = false
        }
        sender.isActivated = true
    }
    
}
