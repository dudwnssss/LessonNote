//
//  CustomTextFieldView.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/02.
//

import UIKit

final class CustomTextFieldView: BaseView {
    
    var limitCount = 0
    var placeholder = ""
    private let underLineView = SeparatorView()
    let textCountLabel = UILabel()
    let textField = UITextField()
    
    
    init(placeholder: String, limitCount: Int) {
        self.limitCount = limitCount
        self.placeholder = placeholder
        super.init(frame: .zero)
        textCountLabel.text = "\(limitCount)"
        setProperties()
        setLayouts()
    }
    
    override func setProperties() {
        textCountLabel.do {
            $0.textColor = Color.gray3
            $0.font = Font.medium14
            $0.textAlignment = .right
        }
        
        textField.do {
            $0.font = Font.medium14
            $0.textColor = Color.gray6
            $0.delegate = self
            $0.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            $0.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: Color.gray3])
        }
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
            $0.centerY.equalTo(textCountLabel)
            $0.leading.equalTo(underLineView).offset(5)
            $0.trailing.equalTo(textCountLabel.snp.leading).offset(-4)
            $0.height.equalTo(30)
        }
        
        snp.makeConstraints {
            $0.height.equalTo(30)
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
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("hihi")
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}
