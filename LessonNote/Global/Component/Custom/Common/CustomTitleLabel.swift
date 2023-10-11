//
//  CustomContentView.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/02.
//

import UIKit

final class CustomTitleLabel: UILabel{
    
    var title = ""
    init(title: String) {
        self.title = title
        super.init(frame: .zero)
        setProperties()
        setLayouts()
    }
    
    private func setProperties() {
            font = Font.bold16
            let fullString = title
            let attrString = NSMutableAttributedString(string: fullString)
            let range = (fullString as NSString).range(of: "*")
            attrString.addAttribute(.foregroundColor, value: Color.blue, range: range)
            textColor = Color.black
            attributedText = attrString
    }
    
    private func setLayouts(){
        snp.makeConstraints {
            $0.height.equalTo(20)
        }
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
