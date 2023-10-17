//
//  CustomLessonTimeView.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/06.
//

import UIKit

final class CustomLessonTimeView: BaseView{
    
    private let title = CustomTitleLabel(title: "요일 및 시간 *")
    let textfield = UITextField()
    private let arrowImageView = UIImageView()

    override func setProperties() {
        textfield.do {
            $0.textColor = Color.gray6
            $0.tintColor = .clear
            $0.text = "월 09:00 - 10:00"
        }
        arrowImageView.do {
            $0.image = Image.arrowDown
        }

    }
    
    override func setLayouts() {
        addSubviews(title, textfield)
        title.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
        }
        textfield.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(16)
            $0.leading.equalToSuperview()
            $0.width.equalTo(150)
        }
        textfield.addSubview(arrowImageView)
        arrowImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        snp.makeConstraints {
            $0.width.equalTo(130)
            $0.height.equalTo(53)
        }
    }
}
