//
//  CustomLessonTimeView.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/06.
//

import UIKit

final class CustomLessonTimeView: BaseView{
    
    private let title = CustomTitleLabel(title: "요일 및 시간 *")
    let textfeild = UITextField()
    private let arrowImageView = UIImageView()

    override func setProperties() {
        textfeild.do {
            $0.tintColor = .clear
            $0.text = "월 09:00 - 10:00"
        }
        arrowImageView.do {
            $0.image = Image.arrowDown
        }

    }
    
    override func setLayouts() {
        addSubviews(title, textfeild)
        title.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
        }
        textfeild.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(16)
            $0.leading.equalToSuperview()
            $0.width.equalTo(150)
        }
        textfeild.addSubview(arrowImageView)
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
