//
//  CustomLessonTimeView.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/06.
//

import UIKit

final class CustomLessonTimeView: BaseView{
    
    let title = CustomTitleLabel(title: "시간 *")
    let lessonTimePiker = LessonTimePickerTextField()
    
    override func setLayouts() {
        addSubviews(title, lessonTimePiker)
        title.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
        }
        lessonTimePiker.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(16)
            $0.leading.equalToSuperview()
        }
        snp.makeConstraints {
            $0.width.equalTo(130)
            $0.height.equalTo(53)
        }
    }
}
