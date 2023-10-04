//
//  CustomButton.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/04.
//

import UIKit

class CustomButton: UIButton {
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
    }
    
    func setProperties(){
        cornerRadius = 10
        configureButton()
    }
        
    func configureButton(){
        switch isActivated{
        case true:
            backgroundColor = Color.gray6
            borderWidth = 0
            setTitleColor(Color.white, for: .normal)
        case false:
            backgroundColor = Color.white
            borderWidth = 1
            borderColor = Color.gray6
            setTitleColor(Color.gray6, for: .normal)
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
