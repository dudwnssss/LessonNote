//
//  CustomCheckInfoLabel.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/05.
//

import UIKit

final class CustomCheckInfoLabel: UILabel {
    
    var infoTitle = ""
    var infoContent = ""{
        didSet{
            setProperties()
        }
    }

    init(title: String, content: String = ""){
        infoTitle = title
        infoContent = content
        super.init(frame: .zero)
        setProperties()
    }
    
    private func setProperties(){
        let fullString = infoTitle + "  |  " + infoContent
        let attrString = NSMutableAttributedString(string: fullString)
        let range = (fullString as NSString).range(of: "\(infoTitle)")
        attrString.addAttribute(.font, value: Font.bold14, range: range)
        font = Font.medium14
        attributedText = attrString
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
