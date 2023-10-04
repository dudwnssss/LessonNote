//
//  StudentInfoView.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/02.
//

import UIKit
import SnapKit

class StudentInfoView: BaseView {
    
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    
    let studentContentView = CustomContentView(title: "학생 이름*", contentView: CustomTextFieldView(placeholder: "학생의 이름을 입력해 주세요", limitCount: 20))
    let iconContentView = CustomContentView(title: "아이콘", contentView: StudentIconStackView())
    let studentPhoneNumberContentView = CustomContentView(title: "학생 전화번호", contentView: CustomPhoneNumberView())
    let parentPhoneNumberContentView = CustomContentView(title: "학부모 전화번호", contentView: CustomPhoneNumberView())
    let nextButton = CompleteButton(title: "다음으로")
    
    override func setProperties() {
        titleLabel.do {
            let fullString = "과외할 학생을\n소개해 주세요"
            let attrString = NSMutableAttributedString(string: fullString)
            let range = (fullString as NSString).range(of: "과외할 학생")
            attrString.addAttribute(.font, value: Font.bold20, range: range)
            $0.font = Font.medium20
            $0.numberOfLines = 0
            $0.attributedText = attrString
        }
        descriptionLabel.do {
            $0.text = "나중에 자유롭게 변경할 수 있어요"
            $0.font = Font.medium12
            $0.textColor = Color.gray4
        }
    }
    
    override func setLayouts() {
        addSubviews(titleLabel, descriptionLabel, studentContentView, iconContentView, studentPhoneNumberContentView, parentPhoneNumberContentView, nextButton)
                
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(25)
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(20)
        }
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(titleLabel)
        }
        
        studentContentView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(36.adjusted)
        }
        
        iconContentView.snp.makeConstraints {
            $0.leading.equalTo(studentContentView)
            $0.top.equalTo(studentContentView.snp.bottom).offset(36.adjusted)
        }
        studentPhoneNumberContentView.snp.makeConstraints {
            $0.leading.equalTo(studentContentView)
            $0.top.equalTo(iconContentView.snp.bottom).offset(36.adjusted)
        }
        parentPhoneNumberContentView.snp.makeConstraints {
            $0.leading.equalTo(studentContentView)
            $0.top.equalTo(studentPhoneNumberContentView.snp.bottom).offset(36.adjusted)
        }

        nextButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().offset(-48)
        }
    }
}
