//
//  CustomWeekCountView.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/06.
//

import UIKit

final class CustomWeekCountView: BaseView{
    
    private let title = CustomTitleLabel(title: "격주 여부")
    let weekCountView = WeekCountView()
    
    override func setLayouts() {
        addSubviews(title, weekCountView)
        title.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
        }
        weekCountView.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview()
        }
        snp.makeConstraints {
            $0.width.equalTo(170)
            $0.height.equalTo(90)
        }
    }
}
