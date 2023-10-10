//
//  EmptyView.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/10.
//

import UIKit

final class EmptyView: BaseView {
    
    private let imageView = UIImageView()
    private let label = UILabel()
    
    override func setProperties() {
        imageView.image = Image.studentEmpty
        label.do {
            $0.text = "아직 등록된 수업이 없어요\n학생을 추가해 보세요"
            $0.textAlignment = .center
            $0.numberOfLines = 0
            $0.font = Font.medium14
            $0.textColor = Color.gray4
        }

    }
    override func setLayouts() {
        addSubviews(imageView, label)
        imageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview()
        }
        label.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }
    }
}
