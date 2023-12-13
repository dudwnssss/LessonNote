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
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = lessonView
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
        
        let textInput = BehaviorRelay<String?>(value: nil)
        lessonView.feedbackTextView.textView.rx.text
            .bind(to: textInput)
            .disposed(by: disposeBag)
        
        
        let output = viewModel.transform(input: LessonViewModel.Input(lessonState: lessonInput, assignmentState: assignmentInput, feedback: textInput, tapCompleteButton: lessonView.completeButton.rx.tap))

        output.lessonState
            .drive(with: self) { owner, value in
                owner.lessonView.lessonStateButtons.forEach { button in
                    button.configureButton(activate: value == button.tag)
                }
            }
            .disposed(by: disposeBag)
        
        output.assignmentState
            .drive(with: self) { owner, value in
                owner.lessonView.assignmentStateButtons.forEach { button in
                    button.configureButton(activate: value == button.tag)
                }
            }.disposed(by: disposeBag)
        
        output.validation
            .bind(with: self) { owner, value in
                owner.lessonView.completeButton.configureButton(isValid: value)
            }
            .disposed(by: disposeBag)
        
        output.feedback
            .drive(with: self, onNext: { owner, value in
                owner.lessonView.feedbackTextView.textView.text = value
                owner.lessonView.feedbackTextView.setPlaceholderColor()
            })
            .disposed(by: disposeBag)
        
        output.upsert.bind(with: self) { owner, _ in
            owner.delegate?.passData()
            owner.navigationController?.popViewController(animated: true)
        }
        .disposed(by: disposeBag)
        
    }
}
