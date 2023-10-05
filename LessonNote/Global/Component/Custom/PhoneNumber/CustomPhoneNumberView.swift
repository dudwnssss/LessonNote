//
//  CustomPhoneNumberView.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/04.
//

import UIKit

class CustomPhoneNumberView: BaseView {
    
    let textFeild1 = UITextField()
    let textFeild2 = UITextField()
    let textFeild3 = UITextField()
    
    let underline1 = SeparatorView()
    let underline2 = SeparatorView()
    let underline3 = SeparatorView()
    
    let divider1 = SeparatorView(color: Color.gray4)
    let divider2 = SeparatorView(color: Color.gray4)
    
    var phoneNumber: String{
        guard let text1 = textFeild1.text else {return ""}
        guard let text2 = textFeild2.text else {return ""}
        guard let text3 = textFeild3.text else {return ""}
        return text1 + text2 + text3
    }
    
    override func setProperties() {
        textFeild1.do {
            $0.font = Font.medium14
            $0.textColor = Color.gray6
            $0.keyboardType = .numberPad
            $0.textAlignment = .center
            $0.delegate = self
            $0.attributedPlaceholder = NSAttributedString(string: "010", attributes: [.foregroundColor: Color.gray3])
        }
        [textFeild2, textFeild3].forEach {
            $0.font = Font.medium14
            $0.textColor = Color.gray6
            $0.keyboardType = .numberPad
            $0.textAlignment = .center
            $0.delegate = self
            $0.attributedPlaceholder = NSAttributedString(string: "XXXX", attributes: [.foregroundColor: Color.gray3])
        }
        [underline1, underline2, underline3].forEach {
            $0.backgroundColor = Color.gray2
        }
        [divider1, divider2].forEach {
            $0.backgroundColor = Color.gray4
        }
    }
    override func setLayouts() {
        addSubviews(textFeild1, textFeild2, textFeild3, underline1, underline2, underline3, divider1, divider2)
 
        underline1.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview()
            $0.width.equalTo(60)
            $0.height.equalTo(1)
        }
        
        textFeild1.snp.makeConstraints {
            $0.bottom.equalTo(underline1.snp.top).offset(-4)
            $0.centerX.equalTo(underline1)
        }
        
        divider1.snp.makeConstraints {
            $0.centerY.equalTo(textFeild1)
            $0.leading.equalTo(underline1.snp.trailing).offset(8)
            $0.width.equalTo(8)
            $0.height.equalTo(1)
        }
        
        underline2.snp.makeConstraints {
            $0.leading.equalTo(divider1.snp.trailing).offset(8)
            $0.bottom.equalTo(underline1)
            $0.width.equalTo(60)
            $0.height.equalTo(1)
        }
        
        textFeild2.snp.makeConstraints {
            $0.centerX.equalTo(underline2)
            $0.bottom.equalTo(textFeild1)
        }
        
        divider2.snp.makeConstraints {
            $0.width.equalTo(8)
            $0.height.equalTo(1)
            $0.centerY.equalTo(textFeild2)
            $0.leading.equalTo(underline2.snp.trailing).offset(8)
        }
        
        underline3.snp.makeConstraints {
            $0.leading.equalTo(divider2.snp.trailing).offset(8)
            $0.bottom.equalTo(underline1)
            $0.width.equalTo(60)
            $0.height.equalTo(1)
        }
        
        textFeild3.snp.makeConstraints {
            $0.centerX.equalTo(underline3)
            $0.bottom.equalTo(textFeild1)
        }
        
        snp.makeConstraints {
            $0.width.equalTo(228)
            $0.height.equalTo(30)
        }
        
    }
}

extension CustomPhoneNumberView: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            // 텍스트 필드의 길이 제한을 설정합니다.
        if textField == textFeild1 {
            let maxLength = 3
            let currentText = textField.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
            
            if newText.count == maxLength {
                textFeild2.becomeFirstResponder()
            }
            
            return newText.count <= maxLength
            
        } else if textField == textFeild2 {
            let maxLength = 4
            let currentText = textField.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
            
            if newText.count == maxLength {
                textFeild3.becomeFirstResponder()
            }
            
            return newText.count <= maxLength
            
        } else if textField == textFeild3 {
            let maxLength = 4
            let currentText = textField.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
            
            return newText.count <= maxLength
        }
        
        return true
    }
}
