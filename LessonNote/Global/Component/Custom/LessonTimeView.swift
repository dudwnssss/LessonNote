//
//  LessonTimeView.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/01.
//

import UIKit

class LessonTimeView: BaseView{
    
    let weekdayLabel = UILabel()
    let lessonTimeLabel = UILabel()
    let separatorView = UIView()
    
    override func setProperties() {
        weekdayLabel.do {
            $0.text = "화"
            $0.textColor = Color.Icon.pink
            $0.font = Font.bold14
        }
        lessonTimeLabel.do {
            $0.text = "18:30 - 19:30"
            $0.font = Font.medium14
        }
        separatorView.do {
            $0.backgroundColor = Color.gray1
        }
    }
    override func setLayouts() {
        addSubviews(weekdayLabel, lessonTimeLabel, separatorView)
        separatorView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        weekdayLabel.snp.makeConstraints {
            $0.leading.equalTo(separatorView)
            $0.bottom.equalTo(separatorView.snp.top).offset(-4)
        }
        lessonTimeLabel.snp.makeConstraints {
            $0.leading.equalTo(weekdayLabel.snp.trailing).offset(8)
            $0.centerY.equalTo(weekdayLabel)
        }
        
    }
}

