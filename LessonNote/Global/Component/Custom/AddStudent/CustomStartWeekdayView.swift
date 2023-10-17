//
//  CustomStartWeekdayView.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/17.
//

import UIKit

final class CustomStartWeekdayView: BaseView {
    
    private let title = CustomTitleLabel(title: "기준 요일은 언제인가요?")
    let weekdayStackView = WeekdayStackView()
    let descriptionLabel = UILabel()
    
    override func setProperties() {
        descriptionLabel.do {
            $0.text = "화요일을 기준으로 주차가 반복됩니다"
            $0.font = Font.medium12
            $0.textColor = Color.gray4
        }
    }
    
    override func setLayouts() {
        addSubviews(title, weekdayStackView, descriptionLabel)
        
        title.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
        }
        
        weekdayStackView.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(weekdayStackView.snp.bottom).offset(8)
            $0.leading.equalToSuperview()
        }
        
    }
}
