//
//  CustomWeekdayView.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/06.
//

import UIKit

final class CustomWeekdayView: BaseView{
    
    let title = CustomTitleLabel(title: "요일 *")
    let weekdayStackView = WeekdayStackView()
    
    override func setLayouts() {
        addSubviews(title, weekdayStackView)
        title.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
        }
        weekdayStackView.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview()
        }
    }
}
