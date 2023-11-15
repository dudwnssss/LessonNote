//
//  MessageView.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/15.
//

import UIKit


final class MessageView: BaseView {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let infoLabel = CustomTitleLabel(title: "")
    let phoneNumberLabel = CustomCheckInfoLabel(title: "", content: "")
    private let messageLabel = CustomTitleLabel(title: "문자 제목")
    let messageTitleTextField = CustomTextFieldView(placeholder: "ex) 안녕하세요, 월간 과외 내역 전송드립니다.", limitCount: 30)
    private let lessonHistoryLabel = CustomTitleLabel(title: "수업 내역 추가")
    private let lessonDescriptionLabel = UILabel()
    let calendarView = CalendarView()
    let assignmentButton = UIButton()
    private let commentLabel = CustomTitleLabel(title: "추가 코멘트")
    let commentTextView = CustomTextView(placeholder: Const.commentPlaceholder, limitCount: 300)
    let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .light))

    let nextButton = CompleteButton(title: "다음으로")
    
    override func setProperties() {

        lessonDescriptionLabel.do {
            $0.text = "추가할 수업일을 선택해주세요"
            $0.font = Font.medium14
            $0.textColor = Color.gray3
        }
        calendarView.do {
            $0.borderWidth = 5
            $0.borderColor = Color.gray1
            $0.today = nil
            $0.allowsMultipleSelection = true
        }
        assignmentButton.do {
            $0.cornerRadius = 8
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = Font.bold14
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
        contentView.addSubviews(infoLabel, phoneNumberLabel, messageLabel, messageTitleTextField, lessonHistoryLabel, lessonDescriptionLabel, calendarView, assignmentButton, commentLabel, commentTextView)
        infoLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalToSuperview().offset(18)
        }
        phoneNumberLabel.snp.makeConstraints {
            $0.leading.equalTo(infoLabel)
            $0.top.equalTo(infoLabel.snp.bottom).offset(16)
        }
        messageLabel.snp.makeConstraints {
            $0.leading.equalTo(infoLabel)
            $0.top.equalTo(phoneNumberLabel.snp.bottom).offset(36)
        }
        messageTitleTextField.snp.makeConstraints {
            $0.top.equalTo(messageLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        lessonHistoryLabel.snp.makeConstraints {
            $0.top.equalTo(messageTitleTextField.snp.bottom).offset(36)
            $0.leading.equalTo(infoLabel)
        }
        lessonDescriptionLabel.snp.makeConstraints {
            $0.leading.equalTo(infoLabel)
            $0.top.equalTo(lessonHistoryLabel.snp.bottom).offset(12)
        }
        calendarView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalTo(lessonDescriptionLabel.snp.bottom).offset(12)
            $0.height.equalTo(calendarView.snp.width)
        }
        assignmentButton.snp.makeConstraints {
            $0.trailing.equalTo(calendarView)
            $0.top.equalTo(calendarView.snp.bottom).offset(12)
            $0.width.equalTo(100)
            $0.height.equalTo(25)
        }
        commentLabel.snp.makeConstraints {
            $0.top.equalTo(assignmentButton.snp.bottom).offset(36)
            $0.leading.equalTo(infoLabel)
        }
        commentTextView.snp.makeConstraints {
            $0.top.equalTo(commentLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.greaterThanOrEqualTo(126)
            $0.bottom.equalToSuperview().offset(-133)
        }
        blurView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.top.equalTo(nextButton.snp.centerY)
        }
        nextButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().offset(-48)
        }
    }
    
    func configureView(student: Student, type: PersonType){
        infoLabel.text = type.title + " 정보"
        phoneNumberLabel.infoTitle = student.studentName + " " + type.title
        switch type {
        case .student:
            guard let phoneNumber = student.studentPhoneNumber else {return}
            phoneNumberLabel.infoContent = phoneNumber.withHypen
        case .parent:
            guard let phoneNumber = student.parentPhoneNumber else {return}
            phoneNumberLabel.infoContent = phoneNumber.withHypen
        }
    }
    
    func configureButton(isSelected: Bool){
        switch isSelected {
        case true:
            assignmentButton.setTitle("과제 내역 해제", for: .normal)
            assignmentButton.backgroundColor = Color.gray4
        case false:
            assignmentButton.setTitle("과제 내역 추가", for: .normal)
            assignmentButton.backgroundColor = Color.gray6
        }
    }
}

