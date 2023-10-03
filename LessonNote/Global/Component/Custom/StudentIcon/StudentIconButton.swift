//
//  StudentIconButton.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/02.
//

import UIKit

class StudentIconButton: UIButton {
    
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

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
