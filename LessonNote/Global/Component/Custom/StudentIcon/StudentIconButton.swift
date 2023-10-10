//
//  StudentIconButton.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/02.
//

import UIKit

final class StudentIconButton: UIButton {
    
    var studentIcon : StudentIcon?
    var isTapped = false {
        didSet {
            configureButton()
        }
    }
    
    init(studentIcon: StudentIcon){
        self.studentIcon = studentIcon
        super.init(frame: .zero)
        setProperties()
        setLayouts()
    }
    
    private func setProperties(){
        setImage(studentIcon?.image, for: .normal)
    }
    
    private func setLayouts(){
        snp.makeConstraints {
            $0.size.equalTo(65)
        }
    }
    
    private func configureButton(){
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
