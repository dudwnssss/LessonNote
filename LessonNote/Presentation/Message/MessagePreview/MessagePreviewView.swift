//
//  MessagePreviewView.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/15.
//

import UIKit
import FSCalendar

class MessagePreviewView: BaseView {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    private let previewLabel = CustomTitleLabel(title: "문자 미리보기")
    let verticalStackView = UIStackView()
    let messageTitleLabel = UILabel()
    let calendarView = CalendarView()
    let commentLabel = UILabel()
    private let logoImageView = UIImageView()
    
    let sendButton = CompleteButton(title: "문자 전송하기")
    
    
    override func setProperties() {
        verticalStackView.do {
            $0.backgroundColor = Color.gray0
            $0.cornerRadius = 15
            $0.axis = .vertical
            $0.spacing = 24
            $0.distribution = .fillProportionally
            $0.alignment = .leading
            $0.layoutMargins = UIEdgeInsets(top: 24, left: 12, bottom: 48, right: 12)
            $0.isLayoutMarginsRelativeArrangement = true
        }
        
        messageTitleLabel.do {
            $0.text = "안녕하세요, 소은 학부모님! 국어 과외 선생님 입니다."
            $0.numberOfLines = 0
            $0.font = Font.medium14
            $0.textColor = Color.gray6
        }
        commentLabel.do {
            $0.text = "소은이가 수업시간에 많이 졸던데 체력을 평소에 많이 많이 보충할 수 있었으면 좋겠습니다. 감사합니다."
            $0.numberOfLines = 0
            $0.font = Font.medium14
            $0.textColor = Color.gray6
        }
        calendarView.do {
            $0.pagingEnabled = false
            $0.allowsSelection = false
            $0.headerHeight = 30
        }
        
        logoImageView.do {
            $0.image = Image.logoText
            $0.contentMode = .scaleAspectFill
        }
    }
    
    override func setLayouts() {
        
        addSubviews(scrollView, sendButton)
        scrollView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
        scrollView.addSubview(contentView)
        
        contentView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.centerX.verticalEdges.equalToSuperview()
        }
        
        contentView.addSubviews(previewLabel, verticalStackView)
        
        previewLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalToSuperview().offset(18)
        }
        
        verticalStackView.snp.makeConstraints {
            $0.top.equalTo(previewLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.lessThanOrEqualToSuperview().offset(-120)
        }
        
        verticalStackView.addArrangedSubviews(messageTitleLabel, calendarView, commentLabel)
        verticalStackView.addSubview(logoImageView)
        
        logoImageView.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview().offset(-12)
        }
        
        calendarView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(12)
        }
        sendButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().offset(-48)
        }
    }
}
