//
//  StudentEditView.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/17.
//

import UIKit

final class StudentEditView: BaseView {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    let studentNameView = CustomStudentNameView()
    let studentIconView = CustomStudentIconView()
    let studentPhoneNumberView = CustomStudentPhoneNumberView()
    let parentPhoneNumberView = CustomParentPhoneNumberView()
    let completeButton = CompleteButton(title: "편집 완료")
    
    
    override func setProperties() {
        
    }
    
    override func setLayouts() {
        addSubviews(scrollView, completeButton)
        scrollView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.centerX.top.bottom.equalToSuperview()
        }
        
    }
    
}
