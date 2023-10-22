//
//  StartDateInfoView.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/05.
//

import UIKit
import FSCalendar

final class StartDateInfoView: BaseView {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .light))

    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    let calendar = CalendarView()
    let nextButton = CompleteButton(title: "다음으로")
    let startWeekdayView = CustomStartWeekdayView()
    
    override func setProperties() {
        titleLabel.do {
            let fullString = "첫 수업 날짜를\n알려주세요"
            let attrString = NSMutableAttributedString(string: fullString)
            let range = (fullString as NSString).range(of: "첫 수업 날짜")
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
        calendar.do {
            $0.borderWidth = 5
            $0.borderColor = Color.gray1
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
        
        contentView.addSubviews(titleLabel, descriptionLabel, calendar, startWeekdayView)
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(25)
            $0.top.equalToSuperview().offset(20)
        }
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(titleLabel)
        }
        
        calendar.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(calendar.snp.width)
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(16)
        }
        
        startWeekdayView.snp.makeConstraints {
            $0.top.equalTo(calendar.snp.bottom).offset(36)
            $0.horizontalEdges.equalToSuperview().inset(25)
            $0.height.equalTo(80)
            $0.bottom.equalToSuperview().offset(-140)
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
