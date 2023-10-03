//
//  CustomTextFieldView.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/02.
//

import UIKit

class CustomTextFieldView: BaseView {
    
    var limitCount = 0
    
    let underLineView = UIView()
    let textCountLabel = UILabel()
    let textField = UITextField()
    
    
    init(placeholder: String, limitCount: Int) {
        self.limitCount = limitCount
        super.init(frame: .zero)
        textCountLabel.text = "\(limitCount)"
        textField.placeholder = placeholder
        setProperties()
        setLayouts()
    }
    
    override func setProperties() {
        textCountLabel.do {
            $0.textColor = Color.gray4
            $0.font = Font.medium14
            $0.textAlignment = .right
        }
        underLineView.do {
            $0.backgroundColor = Color.gray2
        }

        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        updateCountLabel()
    }
    
    override func setLayouts() {
        addSubviews(underLineView, textCountLabel, textField)
        underLineView.snp.makeConstraints {
            
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        textCountLabel.snp.makeConstraints {
            $0.width.equalTo(20)
            $0.trailing.equalToSuperview()
            $0.bottom.equalTo(underLineView.snp.top).offset(-8)
        }
        
        textField.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(textCountLabel.snp.leading).offset(-4)
            $0.top.equalToSuperview()
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        updateCountLabel()
    }
    
    func updateCountLabel() {
        let remainingCount = limitCount - (textField.text?.count ?? 0)
        
        if remainingCount >= 0 {
            textCountLabel.text = "\(remainingCount)"
        } else {
            textCountLabel.text = "0"
        }
        
        if remainingCount < 0 {
            textField.text = String(textField.text?.prefix(limitCount) ?? "")
        }
    }
}

extension CustomTextFieldView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}
