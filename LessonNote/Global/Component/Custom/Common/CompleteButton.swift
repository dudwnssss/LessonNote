//
//  CompleteButton.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/02.
//

import UIKit

final class CompleteButton: UIButton {
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
    
    private func setProperties(){
        cornerRadius = 10
        configureButton()
    }
    
    private func setLayouts(){
        snp.makeConstraints {
            $0.height.equalTo(48)
        }
    }
    
    private func configureButton(){
        backgroundColor = isActivated ? Color.black : Color.gray4
//        isUserInteractionEnabled = isActivated
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

