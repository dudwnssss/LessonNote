//
//  CustomContentView.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/02.
//

import UIKit

class CustomContentView: BaseView{
    
    var title = ""
    let titleLabel = UILabel()
    var contentView = UIView()
    
    init(title: String, contentView: UIView) {
        self.title = title
        self.contentView = contentView
        super.init(frame: .zero)
    }
    
    override func setProperties() {
        contentView.backgroundColor = .systemTeal
        titleLabel.do {
            $0.font = Font.bold16
            let fullString = title
            let attrString = NSMutableAttributedString(string: fullString)
            let range = (fullString as NSString).range(of: "*")
            attrString.addAttribute(.foregroundColor, value: Color.blue, range: range)
            titleLabel.textColor = Color.black
            titleLabel.attributedText = attrString
        }
    }
    override func setLayouts() {
        addSubviews(titleLabel, contentView)
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()
        }
        contentView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
