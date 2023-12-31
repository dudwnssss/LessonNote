//
//  StudentInfoViewController.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/02.
//

import UIKit
import Toast
import RxSwift
import RxCocoa


final class StudentInfoViewController: BaseViewController {
    
    private let studentInfoView = StudentInfoView()
    private let studentInfoViewModel = StudentInfoViewModel()
    var disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = studentInfoView
    }
    
    override func setNavigationBar() {
        navigationItem.title = "학생 추가"
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    
    override func setProperties() {
        hideKeyboardWhenTappedAround()
        studentInfoView.nextButton.addTarget(self, action: #selector(nextButtonDidTap), for: .touchUpInside)
        studentInfoView.studentNameView.textfieldView.textField.addTarget(self, action: #selector(nameTextFieldDidChange), for: .editingChanged)
        studentInfoView.studentPhoneNumberView.textfieldView.textField.addTarget(self, action: #selector(studentNumberTextFieldDidChange), for: .editingChanged)
        studentInfoView.parentPhoneNumberView.textfieldView.textField.addTarget(self, action: #selector(parentNumberTextFieldDidChange), for: .editingChanged)
        studentInfoView.studentIconView.iconStackView.studentIconButtonList.forEach {
            $0.addTarget(self, action: #selector(studentIconButtonDidTap(sender:)), for: .touchUpInside)
        }
        
    }
    
    @objc func studentIconButtonDidTap(sender: StudentIconButton){
        studentInfoViewModel.studentIcon.value = sender.studentIcon
    }
    
    @objc func nextButtonDidTap(){
        if let message = studentInfoViewModel.message {
            var style = ToastStyle()
            style.messageFont = Font.medium14
            self.view.makeToast(message, duration: 1, position: .top, style: style)
            return
        }
        let vc = LessonInfoViewController()
        navigationController?.pushViewController(vc, animated: true)
        studentInfoViewModel.storeData()
    }
    
    @objc func nameTextFieldDidChange(){
        if let text = studentInfoView.studentNameView.textfieldView.textField.text {
            studentInfoViewModel.name.value = text
        }
    }
    
    @objc func studentNumberTextFieldDidChange(){
        if let text = studentInfoView.studentPhoneNumberView.textfieldView.textField.text {
            studentInfoViewModel.studentPhoneNumber.value = text
        }
    }
    @objc func parentNumberTextFieldDidChange(){
        if let text = studentInfoView.parentPhoneNumberView.textfieldView.textField.text {
            studentInfoViewModel.parentPhoneNumber.value = text
        }
    }
    
    override func bind() {
        studentInfoViewModel.isValid.bind {[weak self] value in
            self?.studentInfoView.nextButton.configureButton(isValid: value)
        }
        
        studentInfoView.studentNameView.textfieldView.textField.rx.text.bind { [weak self] _ in
            self?.studentInfoViewModel.checkValidation()
        }
        .disposed(by: disposeBag)
        
        studentInfoViewModel.studentPhoneNumber.bind { [weak self] value in
            self?.studentInfoView.studentPhoneNumberView.textfieldView.textField.text = value
            self?.studentInfoViewModel.checkValidation()
        }
        
        studentInfoViewModel.parentPhoneNumber.bind { [weak self] value in
            self?.studentInfoView.parentPhoneNumberView.textfieldView.textField.text = value
            self?.studentInfoViewModel.checkValidation()
        }
        studentInfoViewModel.studentIcon.bind { value in
            self.studentInfoView.studentIconView.iconStackView.studentIconButtonList.forEach({
                $0.configureButton(isSelected: value == $0.studentIcon)
            })
        }
        
    }
}

