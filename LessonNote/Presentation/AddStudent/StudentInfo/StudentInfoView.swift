//
//  StudentInfoView.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/02.
//

import UIKit
import SnapKit

final class StudentInfoView: BaseView {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let studentNameView = CustomStudentNameView()
    let studentIconView = CustomStudentIconView()
    let studentPhoneNumberView = CustomStudentPhoneNumberView()
    let parentPhoneNumberView = CustomParentPhoneNumberView()
    let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
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
        addSubviews(scrollView, blurView, nextButton)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.centerX.top.bottom.equalToSuperview()
        }
        
        contentView.addSubviews(titleLabel, descriptionLabel, studentNameView, studentIconView, studentPhoneNumberView, parentPhoneNumberView)
                
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(25)
            $0.top.equalToSuperview().offset(20)
        }
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(titleLabel)
        }
        
        studentNameView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(25)
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(36)
        }
        
        studentIconView.snp.makeConstraints {
            $0.leading.equalTo(studentNameView)
            $0.top.equalTo(studentNameView.snp.bottom).offset(36)
        }
        studentPhoneNumberView.snp.makeConstraints {
            $0.leading.equalTo(studentNameView)
            $0.top.equalTo(studentIconView.snp.bottom).offset(36)
        }
        parentPhoneNumberView.snp.makeConstraints {
            $0.leading.equalTo(studentNameView)
            $0.top.equalTo(studentPhoneNumberView.snp.bottom).offset(36)
            $0.bottom.equalToSuperview().offset(-141)
        }
        blurView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.top.equalTo(nextButton.snp.centerY)
        }
        nextButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().offset(-48.adjusted)
        }
    }
}
