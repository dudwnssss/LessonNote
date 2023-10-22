//
//  CompleteButton.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/02.
//

import UIKit

final class CompleteButton: UIButton {
    var buttonTitle: String?

    init(title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setProperties()
        setLayouts()
    }
    
    private func setProperties(){
        cornerRadius = 10
        configureButton(isValid: false)
    }
    
    private func setLayouts(){
        snp.makeConstraints {
            $0.height.equalTo(48)
        }
    }
    
    func configureButton(isValid: Bool){
        backgroundColor = isValid ? Color.black : Color.gray4
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

