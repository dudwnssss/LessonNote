//
//  CustomContentView.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/02.
//

import UIKit

class CustomContentView: BaseView{
    
    let titleLabel = UILabel()
    var contentView = UIView()
    
    init(title: String, contentView: UIView) {
        titleLabel.text = title
        self.contentView = contentView
        super.init(frame: .zero)
    }
    
    override func setProperties() {
        titleLabel.do {
            $0.font = Font.bold16
        }
    }
    override func setLayouts() {
        addSubviews(titleLabel, contentView)
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(5)
            $0.top.equalToSuperview()
        }
        contentView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
}
