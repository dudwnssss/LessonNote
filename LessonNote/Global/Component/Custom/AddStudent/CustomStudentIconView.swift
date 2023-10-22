//
//  CustomStudentIconView.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/06.
//

import UIKit

final class CustomStudentIconView: BaseView{
    
    private let title = CustomTitleLabel(title: "아이콘")
    let iconStackView = StudentIconStackView()
    
    override func setLayouts() {
        addSubviews(title, iconStackView)
        title.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
        }
        iconStackView.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(16)
            $0.leading.equalToSuperview()
        }
        snp.makeConstraints {
            $0.height.equalTo(174)
            $0.width.equalTo(340.adjusted)
        }
    }
}
