//
//  CustomCheckInfoView.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/05.
//

import UIKit

class CustomCheckInfoView: BaseView {
    
    let punchImageView = UIImageView()
    let iconImageView = UIImageView()
    let backgroundView = UIView()
    
    let nameLabel = CustomCheckInfoLabel(title: "이름", content: TempStudent.shared.studentName!)
    let studentPhoneNumberLabel = CustomCheckInfoLabel(title: "전화번호", content: TempStudent.shared.studentPhoneNumber!)
    let parentPhoneNumberLabel = CustomCheckInfoLabel(title: "학부모 전화번호", content: TempStudent.shared.parentPhoneNumber!)
    
    let weekCountLabel = CustomCheckInfoLabel(title: "격주 여부", content: "2주마다 수업")
    let startDateLabel = CustomCheckInfoLabel(title: "수업 시작일", content: "2023년 9월 25일 (월)")
    let separator1 = SeparatorView(color: Color.gray1)
    let separator2 = SeparatorView(color: Color.gray1)

    override func setProperties() {
        punchImageView.do {
            $0.image = Image.notePunched
            $0.contentMode = .scaleAspectFill
        }
        backgroundView.do {
            $0.backgroundColor = Color.white
            $0.clipsToBounds = true
            $0.cornerRadius = 20
            $0.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        }
        iconImageView.do {
            $0.image = TempStudent.shared.studentIcon?.image
        }

    }
    
    override func setLayouts() {
        addSubviews(punchImageView, backgroundView)
        punchImageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
        }
        backgroundView.snp.makeConstraints {
            $0.top.equalTo(punchImageView.snp.bottom)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
        backgroundView.addSubviews(iconImageView, nameLabel, studentPhoneNumberLabel, parentPhoneNumberLabel, weekCountLabel, startDateLabel, separator1, separator2)
        iconImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(20)
            $0.size.equalTo(65)
        }
    }
    
    
}
