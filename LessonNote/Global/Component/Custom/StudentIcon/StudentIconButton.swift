//
//  StudentIconButton.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/02.
//

import UIKit

class StudentIconButton: UIButton {
    
    var isTapped = false {
        didSet {
            configureButton()
        }
    }
    
    init(studentIcon: StudentIcon){
        super.init(frame: .zero)
        setImage(studentIcon.image, for: .normal)
        setLayouts()
        
    }
    
    func setLayouts(){
        snp.makeConstraints {
            $0.size.equalTo(65)
        }
    }
    
    func configureButton(){
        switch self.isTapped{
        case true:
            borderWidth = 2
            borderColor = .black
        case false:
            borderWidth = 0
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cornerRadius = frame.width / 2
    }
    

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
