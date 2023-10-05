//
//  CompleteButton.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/02.
//

import UIKit

class CompleteButton: UIButton {
    var buttonTitle: String?
    var isActivated = false {
        didSet {
            configureButton()
        }
    }
    init(title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setProperties()
        setLayouts()
    }
    
    func setProperties(){
        cornerRadius = 10
        configureButton()
    }
    
    func setLayouts(){
        snp.makeConstraints {
            $0.height.equalTo(48)
        }
    }
    
    func configureButton(){
        backgroundColor = isActivated ? Color.black : Color.gray4
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

