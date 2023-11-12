//
//  LessonViewController.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/11.
//

import UIKit
import RxSwift
import RxCocoa

protocol PassData: AnyObject {
    func passData()
}

final class LessonViewController: BaseViewController {
    
    weak var delegate: PassData?
    private let lessonView = LessonView()
    let viewModel = LessonViewModel()
    
    
    override func loadView() {
        self.view = lessonView
    }
    
    override func setProperties() {
        viewModel.loadState()
        
        lessonView.lessonStateButtons.forEach { button in
            button.addTarget(self, action: #selector(lessonStateButtonDidTap(sender:)), for: .touchUpInside)
        }
        lessonView.assignmentStateButtons.forEach { button in
            button.addTarget(self, action: #selector(assignmentStateButtonDidtap(sender:)), for: .touchUpInside)
        }
        
        lessonView.completeButton.addTarget(self, action: #selector(completeButtonDidTap), for: .touchUpInside)
    }
    
    override func bind() {
        
//        viewModel.assignmentState.value
//        
//        Observable.combineLatest(lessonView.lessonStateButtons.map{ $0.rawvalue })
//        
//        let input = LessonViewModel.Input(lessonState: <#T##ControlProperty<LessonState>#>, assignmentState: <#T##ControlProperty<AssignmentState>#>, feedback: <#T##ControlProperty<String>#>, tapCompleteButton: <#T##ControlEvent<Void>#>)
        
        
        viewModel.lessonState.bind { state in
            self.lessonView.lessonStateButtons.forEach { button in
                button.configureButton(activate: state?.rawValue == button.tag)
            }
        }
        viewModel.assignmentState.bind { state in
            self.lessonView.assignmentStateButtons.forEach { button in
                button.configureButton(activate: state?.rawValue == button.tag)
            }
        }
        viewModel.feedback.bind { text in
            if let text {
                self.lessonView.feedbackTextView.textView.do {
                    $0.text = text
                    $0.textColor = Color.gray6
                }
            }
        }
        viewModel.isValid.bind { [weak self] value in
            self?.lessonView.completeButton.configureButton(isValid: value)
        }
    }
    
    @objc func lessonStateButtonDidTap(sender: CustomButton){
        if viewModel.lessonState.value?.rawValue == sender.tag {
            viewModel.lessonState.value = nil
        } else {
            viewModel.lessonState.value = LessonState(rawValue: sender.tag)
        }
    }
    
    @objc func assignmentStateButtonDidtap(sender: CustomButton){
        if viewModel.assignmentState.value?.rawValue == sender.tag {
            viewModel.assignmentState.value = nil
        } else {
            viewModel.assignmentState.value = AssignmentState(rawValue: sender.tag)
        }
    }
    
    @objc func completeButtonDidTap(){
        if lessonView.feedbackTextView.textView.text == lessonView.feedbackTextView.placeholder {
            viewModel.feedback.value = nil
        } else {
            viewModel.feedback.value =  lessonView.feedbackTextView.textView.text
        }
        viewModel.upsertLesson()
        delegate?.passData()
        navigationController?.popViewController(animated: true)
    }

}
