//
//  WeekCountView.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/04.
//

import UIKit

class WeekCountView: BaseView{
    

    let checkboxButton = CheckBoxButton()
    let titleLabel = UILabel()
    let textField = CustomTextFieldView(placeholder: "2", limitCount: 1)
    let numberPickerView = NumberPickerView()
    let descriptionLabel = UILabel()
    
    override func setProperties() {
        backgroundColor = .systemPink
        titleLabel.do {
            $0.text = "격주로 수업해요"
        }
        textField.do {
            $0.textCountLabel.isHidden = true
            $0.textField.inputView = numberPickerView.inputView
        }
        descriptionLabel.do {
            $0.text = "주 마다"
        }
        checkboxButton.addTarget(self, action: #selector(checkboxButtonDidTap), for: .touchUpInside)
        configureView()
    }
    
    override func setLayouts() {
        addSubviews(checkboxButton, titleLabel, textField, descriptionLabel)
        
        checkboxButton.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
        }
        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(checkboxButton)
            $0.leading.equalTo(checkboxButton.snp.trailing).offset(8)
        }
        textField.snp.makeConstraints {
            $0.leading.equalTo(titleLabel)
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.width.equalTo(91.adjusted)
        }
        descriptionLabel.snp.makeConstraints {
            $0.centerY.equalTo(textField)
            $0.leading.equalTo(textField.snp.trailing).offset(6)
        }
        snp.makeConstraints {
            $0.height.equalTo(60)
        }
    }
    
    
    @objc func checkboxButtonDidTap(){
        print(#fileID, #function, #line, "- ")
        checkboxButton.isTapped.toggle()
        configureView()
    }
    
    
    func configureView(){
        switch checkboxButton.isTapped{
        case true:
            textField.isHidden = false
            descriptionLabel.isHidden = false
        case false:
            textField.isHidden = true
            descriptionLabel.isHidden = true
        }
    }
}