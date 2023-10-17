//
//  CustomStudentNameView.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/06.
//

import UIKit

final class CustomStudentNameView: BaseView{
    
    private let title = CustomTitleLabel(title: "학생 이름 *")
    let textfieldView = CustomTextFieldView(placeholder: "학생의 이름을 입력해주세요", limitCount: 20)
    
    override func setLayouts() {
        addSubviews(title, textfieldView)
        title.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
        }
        textfieldView.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview()
        }
        snp.makeConstraints {
            $0.width.equalTo(230.adjusted)
            $0.height.equalTo(52)
        }
    }
}
