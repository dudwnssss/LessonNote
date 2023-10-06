//
//  CustomStudentPhoneNumberView.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/06.
//

import UIKit

final class CustomStudentPhoneNumberView: BaseView{
    
    let title = CustomTitleLabel(title: "학생 전화번호")
    let textFeildView = CustomTextFieldView(placeholder: "01012341234", limitCount: 11)
    
    override func setProperties() {
        textFeildView.do {
            $0.textCountLabel.isHidden = true
            $0.textField.keyboardType = .numberPad
        }
    }
    
    override func setLayouts() {
        addSubviews(title, textFeildView)
        title.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
        }
        textFeildView.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(16)
            $0.leading.equalToSuperview()
        }
        
        snp.makeConstraints {
            $0.width.equalTo(228)
            $0.height.equalTo(52)
        }
    }
}
