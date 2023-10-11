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
    
    let completedLessonButton = CustomButton(title: "정상 수업")
    let supplementedLessonButton = CustomButton(title: "보강")
    let canceledLessonButton = CustomButton(title: "휴강")
    let noneLessonButton = CustomButton(title: "수업 없음")
    
    let goodAssignmentButton = CustomButton(title: "O 완료")
    let sosoAssignmentButton = CustomButton(title: "△ 미흡")
    let badAssginmentButton = CustomButton(title: "X 미수행")
    
    lazy var LessonButtons = [completedLessonButton, supplementedLessonButton, canceledLessonButton, noneLessonButton]
    lazy var AssignmentButtons = [goodAssignmentButton, sosoAssignmentButton, badAssginmentButton]
    
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
        
        LessonButtons.forEach {
            lessonStackView.addArrangedSubview($0)
        }
        AssignmentButtons.forEach {
            assignmentStackView.addArrangedSubview($0)
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
