//
//  LessonVIew.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/11.
//

import UIKit

final class LessonView: BaseView {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let lessonStatusLabel = CustomTitleLabel(title: "수업 상태")
    private let assignmentStatusLabel = CustomTitleLabel(title: "과제 상태")
    
    private let lessonSates = LessonState.allCases
    private let assignmentStates = AssignmentState.allCases
    
    var lessonStateButtons: [CustomButton] = []
    var assignmentStateButtons: [CustomButton] = []
    
    private let feedbackLabel = CustomTitleLabel(title: "피드백")
    private let lessonStackView = UIStackView()
    private let assignmentStackView = UIStackView()
    let completeButton = CompleteButton(title: "작성완료")
    let feedbackTextView = CustomTextView(placeholder: "오늘 수업은 어떠셨나요?\n자유롭게 수업에 대한 기록을 남길 수 있어요.", limitCount: 500)
    
    override func setProperties() {
        lessonStackView.do {
            $0.axis = .horizontal
            $0.spacing = 8
            $0.distribution = .fillEqually
        }
        assignmentStackView.do {
            $0.axis = .horizontal
            $0.spacing = 8
            $0.distribution = .fillEqually
        }
        lessonSates.forEach {
            let button = CustomButton(title: $0.title)
            button.tag = $0.rawValue
            lessonStateButtons.append(button)
        }
        
        assignmentStates.forEach {
            let button = CustomButton(title: $0.title)
            button.tag = $0.rawValue
            assignmentStateButtons.append(button)
        }
    }
    override func setLayouts() {
        addSubviews(scrollView, completeButton)
        scrollView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.centerX.top.bottom.equalToSuperview()
        }
        
        contentView.addSubviews(lessonStatusLabel, lessonStackView, assignmentStatusLabel, assignmentStackView, feedbackLabel, feedbackTextView)
        
        lessonStateButtons.forEach {
            lessonStackView.addArrangedSubview($0)
        }
        assignmentStateButtons.forEach {
            assignmentStackView.addArrangedSubview($0)
        }
        
        lessonStatusLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalToSuperview().offset(18)
        }
        lessonStackView.snp.makeConstraints {
            $0.top.equalTo(lessonStatusLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(40)
        }
        assignmentStatusLabel.snp.makeConstraints {
            $0.leading.equalTo(lessonStatusLabel)
            $0.top.equalTo(lessonStackView.snp.bottom).offset(36)
        }
        assignmentStackView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalTo(assignmentStatusLabel.snp.bottom).offset(16)
            $0.height.equalTo(40)
        }
        feedbackLabel.snp.makeConstraints {
            $0.leading.equalTo(lessonStatusLabel)
            $0.top.equalTo(assignmentStackView.snp.bottom).offset(36)
        }
        feedbackTextView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalTo(feedbackLabel.snp.bottom).offset(16)
            $0.height.equalTo(feedbackTextView.snp.width)
            $0.bottom.equalToSuperview().offset(-130)
        }
        
        completeButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().offset(-48)
        }
    }

}
