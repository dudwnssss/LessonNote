//
//  CustomStudentPhoneNumberView.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/06.
//

import UIKit

final class CustomStudentPhoneNumberView: BaseView{
    
    private let title = CustomTitleLabel(title: "학생 전화번호")
    let textfieldView = CustomTextFieldView(placeholder: "01012341234", limitCount: 11)
    
    override func setProperties() {
        textfieldView.do {
            $0.textCountLabel.isHidden = true
            $0.textField.keyboardType = .numberPad
        }
    }
    
    override func setLayouts() {
        addSubviews(title, textfieldView)
        title.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
        }
        textfieldView.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(16)
            $0.leading.equalToSuperview()
        }
        
        snp.makeConstraints {
            $0.width.equalTo(228)
            $0.height.equalTo(52)
        }
    }
}
