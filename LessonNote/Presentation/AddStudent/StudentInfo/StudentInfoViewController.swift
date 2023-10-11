//
//  StudentInfoViewController.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/02.
//

import UIKit

final class StudentInfoViewController: BaseViewController {
    
    private let studentInfoView = StudentInfoView()
    private let studentInfoViewModel = StudentInfoViewModel()
    
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
        studentInfoView.studentNameView.textFeildView.textField.addTarget(self, action: #selector(nameTextFieldDidChange), for: .editingChanged)
        studentInfoView.studentPhoneNumberView.textFeildView.textField.addTarget(self, action: #selector(studentNumberTextFieldDidChange), for: .editingChanged)
        studentInfoView.parentPhoneNumberView.textFeildView.textField.addTarget(self, action: #selector(parentNumberTextFieldDidChange), for: .editingChanged)
    }
    
    @objc func nextButtonDidTap(){
        let vc = LessonInfoViewController()
        navigationController?.pushViewController(vc, animated: true)
        studentInfoViewModel.storeData()
        TempStudent.shared.studentIcon = studentInfoView.studentIconView.iconStackView.selectedIcon
    }
    
    @objc func nameTextFieldDidChange(){
        if let text = studentInfoView.studentNameView.textFeildView.textField.text {
            studentInfoViewModel.name.value = text
            studentInfoViewModel.checkValidation()
        }
    }
    
    @objc func studentNumberTextFieldDidChange(){
        if let text = studentInfoView.studentPhoneNumberView.textFeildView.textField.text {
            studentInfoViewModel.studentPhoneNumber.value = text
            studentInfoViewModel.checkValidation()
        }
    }
    @objc func parentNumberTextFieldDidChange(){
        if let text = studentInfoView.parentPhoneNumberView.textFeildView.textField.text {
            studentInfoViewModel.parentPhoneNumber.value = text
            studentInfoViewModel.checkValidation()
        }
    }
    
    override func bind() {
        studentInfoViewModel.isValid.bind {[weak self] value in
            self?.studentInfoView.nextButton.isActivated = value
        }
        studentInfoViewModel.name.bind { [weak self] value in
            self?.studentInfoView.studentNameView.textFeildView.textField.text = value
        }
        studentInfoViewModel.studentPhoneNumber.bind { [weak self] value in
            self?.studentInfoView.studentPhoneNumberView.textFeildView.textField.text = value
        }
        studentInfoViewModel.parentPhoneNumber.bind { [weak self] value in
            self?.studentInfoView.parentPhoneNumberView.textFeildView.textField.text = value
        }
    }
}

