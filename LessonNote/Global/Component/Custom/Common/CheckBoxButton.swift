//
//  CheckBoxButton.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/04.
//

import UIKit

final class CheckBoxButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func configureCheckbox(check: Bool){
        print(#fileID, #function, #line, "- ")
        switch check{
        case true:
            setImage(Image.checkboxFill, for: .normal)
        case false:
            setImage(Image.checkbox, for: .normal)
        }
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
