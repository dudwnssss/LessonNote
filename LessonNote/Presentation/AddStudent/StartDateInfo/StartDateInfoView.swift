//
//  StartDateInfoView.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/05.
//

import UIKit
import FSCalendar

class StartDateInfoView: BaseView {
    
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let calendar = CalendarView()
    let nextButton = CompleteButton(title: "다음으로")
    
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
        addSubviews(titleLabel, descriptionLabel, calendar, nextButton)
                
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(25)
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(20)
        }
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(titleLabel)
        }
        
        calendar.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(calendar.snp.width)
            $0.centerY.equalToSuperview().offset(-4)
        }

        nextButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().offset(-48.adjusted)
        }
    }
}
