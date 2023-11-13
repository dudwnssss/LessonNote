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
    
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = lessonView
    }
    
    override func setProperties() {
//        viewModel.loadState(lessonState: <#BehaviorRelay<Int?>#>, assignmentState: <#BehaviorRelay<Int?>#>, feedback: <#ControlProperty<String?>#>)
    }
    
    override func bind() {
        
        let lessonInput = BehaviorRelay<Int?>(value: nil)
        lessonView.lessonStateButtons.forEach { button in
            button.rx.tap
                .bind(with: self) { owner, _ in
                    if lessonInput.value == button.tag {
                        lessonInput.accept(nil)
                    } else {
                        lessonInput.accept(button.tag)
                    }
                }
                .disposed(by: disposeBag)
        }
        
        let assignmentInput = BehaviorRelay<Int?>(value: nil)
        lessonView.assignmentStateButtons.forEach { button in
            button.rx.tap
                .bind(with: self) { owner, _ in
                    if assignmentInput.value == button.tag {
                        assignmentInput.accept(nil)
                    } else {
                        assignmentInput.accept(button.tag)
                    }
                }
                .disposed(by: disposeBag)
        }
        
        let output = viewModel.transform(input: LessonViewModel.Input(lessonState: lessonInput, assignmentState: assignmentInput, feedback: lessonView.feedbackTextView.textView.rx.text, tapCompleteButton: lessonView.completeButton.rx.tap))

        output.lessonState
            .bind(with: self) { owner, value in
                owner.lessonView.lessonStateButtons.forEach { button in
                    button.configureButton(activate: value == button.tag)
                }
            }
            .disposed(by: disposeBag)
        
        output.assignmentState
            .bind(with: self) { owner, value in
                owner.lessonView.assignmentStateButtons.forEach { button in
                    button.configureButton(activate: value == button.tag)
                }
            }.disposed(by: disposeBag)
        
        output.validation
            .bind(with: self) { owner, value in
                owner.lessonView.completeButton.configureButton(isValid: value)
            }
            .disposed(by: disposeBag)
        
        output.feedback.bind(with: self) { owner, text in
            if let text {
                owner.lessonView.feedbackTextView.textView.do {
                    $0.text = text
                    $0.textColor = Color.gray6
                }

            }
        }
        .disposed(by: disposeBag)
        
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
