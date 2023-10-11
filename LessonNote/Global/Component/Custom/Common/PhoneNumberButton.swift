//
//  PhoneNumberButton.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/10.
//

import UIKit

final class PhoneNumberButton: UIButton {
    
    var buttonTitle = ""
    
    init(title: String) {
        self.buttonTitle = title
        super.init(frame: .zero)
        setProperties()
        setLayouts()
    }
    
    private func setProperties(){
        setTitle(buttonTitle, for: .normal)
        setImage(Image.phoneWhite, for: .normal)
        titleLabel?.font = Font.medium12
        titleLabel?.textColor = Color.white
        titleLabel?.numberOfLines = 1
        imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        backgroundColor = Color.gray5
        cornerRadius = 5
    }
    
    private func setLayouts(){
        snp.makeConstraints {
            $0.height.equalTo(24)
        }
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}