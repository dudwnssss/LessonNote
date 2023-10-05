//
//  SeparatorView.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/04.
//

import UIKit

class SeparatorView: BaseView {
    
    var bgColor = Color.gray2
    
    init(color: UIColor = Color.gray2){
        bgColor = color
        super.init(frame: .zero)
    }

    override func setProperties() {
        backgroundColor = bgColor
    }
    override func setLayouts() {
        snp.makeConstraints {
            $0.height.equalTo(1)
        }
    }
    
}
