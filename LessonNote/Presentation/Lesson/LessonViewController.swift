//
//  LessonViewController.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/11.
//

import UIKit

protocol PassData{
    func passData()
}

final class LessonViewController: BaseViewController {
    
    private let lessonView = LessonView()
    let lessonViewModel = LessonViewModel()
    
    var delegate: PassData?
    
    override func loadView() {
        self.view = lessonView
    }
    
    override func setProperties() {
        lessonViewModel.loadState()
        lessonView.lessonStateButtons.forEach { button in
            button.addTarget(self, action: #selector(lessonStateButtonDidTap(sender:)), for: .touchUpInside)
        }
        lessonView.assignmentStateButtons.forEach { button in
            button.addTarget(self, action: #selector(assignmentStateButtonDidtap(sender:)), for: .touchUpInside)
        }
        lessonView.completeButton.addTarget(self, action: #selector(compeleteButtonDidTap), for: .touchUpInside)
    }
    

    
    override func bind() {
        lessonViewModel.lessonState.bind { state in
            self.lessonView.lessonStateButtons.forEach { button in
                button.configureButton(activate: state?.rawValue == button.tag)
            }
        }
        lessonViewModel.assignmentState.bind { state in
            self.lessonView.assignmentStateButtons.forEach { button in
                button.configureButton(activate: state?.rawValue == button.tag)
            }
        }
        lessonViewModel.feedback.bind { text in
            if let text {
                self.lessonView.feedbackTextView.textView.do {
                    $0.text = text
                    $0.textColor = Color.gray6
                }

            }
        }
        lessonViewModel.isValid.bind { [weak self] value in
            self?.lessonView.completeButton.configureButton(isValid: value)
        }
    }
    
    @objc func lessonStateButtonDidTap(sender: CustomButton){
        lessonViewModel.lessonState.value = LessonState(rawValue: sender.tag)
    }
    
    @objc func assignmentStateButtonDidtap(sender: CustomButton){
        lessonViewModel.assignmentState.value = AssignmentState(rawValue: sender.tag)
    }

    
    @objc func compeleteButtonDidTap(){
        navigationController?.popViewController(animated: true)
        lessonViewModel.feedback.value =  lessonView.feedbackTextView.textView.text
        lessonViewModel.upsertLesson()
        delegate?.passData()
    }

}
