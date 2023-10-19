//
//  CustomStudentView.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/10.
//

import UIKit

class CustomStudentView: BaseView{
    let iconImageView = UIImageView()
    let nameLabel = UILabel()
    let studentLabel = UILabel()
    let weekCountLabel = UILabel()
    private let separatorView = SeparatorView(color: Color.gray1)
    private let lessonTimeStackView = UIStackView()
    private let punchImageView = UIImageView()
    private let cellBackgroundView = UIView()
    let studentPhoneNumberButton = PhoneNumberButton(title: "학생 연락처")
    let parentPhoneNumberButton = PhoneNumberButton(title: "학부모 연락처")
    let stackView = UIStackView()
    override func setProperties() {
        punchImageView.do {
            $0.image = Image.notePunched
            $0.contentMode = .scaleAspectFill
        }
        weekCountLabel.do {
            $0.font = Font.bold12
        }
        nameLabel.do {
            $0.text = "안소은"
            $0.font = Font.bold16
        }
        studentLabel.do {
            $0.text = "학생"
            $0.textColor = Color.gray4
            $0.font = Font.bold14
        }
        cellBackgroundView.do {
            $0.backgroundColor = Color.white
            $0.clipsToBounds = true
            $0.cornerRadius = 20
            $0.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        }
        lessonTimeStackView.do {
            $0.axis = .vertical
            $0.spacing = 4
            $0.alignment = .leading
        }
        stackView.do {
            $0.axis = .horizontal
            $0.spacing = 4
            $0.distribution = .fillProportionally
        }
    }
    
    override func setLayouts() {
        addSubviews(punchImageView, cellBackgroundView)
        punchImageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
        }
        cellBackgroundView.snp.makeConstraints {
            $0.top.equalTo(punchImageView.snp.bottom)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
        cellBackgroundView.addSubviews(iconImageView, nameLabel, studentLabel, separatorView, lessonTimeStackView, studentPhoneNumberButton, parentPhoneNumberButton, stackView, weekCountLabel)
        iconImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.leading.equalToSuperview().offset(18)
            $0.size.equalTo(65)
            $0.bottom.lessThanOrEqualToSuperview().offset(-25)
        }
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(iconImageView)
            $0.leading.equalTo(iconImageView.snp.trailing).offset(24)
        }
        studentLabel.snp.makeConstraints {
            $0.centerY.equalTo(nameLabel)
            $0.leading.equalTo(nameLabel.snp.trailing).offset(4)
        }
        separatorView.snp.makeConstraints {
            $0.leading.equalTo(nameLabel)
            $0.width.equalTo(stackView)
            $0.top.equalTo(nameLabel.snp.bottom).offset(4)
        }
        weekCountLabel.snp.makeConstraints {
            $0.trailing.equalTo(separatorView)
            $0.bottom.equalTo(nameLabel)
        }
        lessonTimeStackView.snp.makeConstraints {
            $0.top.equalTo(separatorView.snp.bottom)
            $0.horizontalEdges.equalTo(separatorView)
        }
        stackView.addArrangedSubviews(studentPhoneNumberButton, parentPhoneNumberButton)
        stackView.snp.makeConstraints {
            $0.leading.equalTo(separatorView)
            $0.top.equalTo(lessonTimeStackView.snp.bottom).offset(4)
            $0.width.equalTo(200)
            $0.bottom.equalToSuperview().offset(-25)
        }
    }
    
    func configureView(student: Student){
        nameLabel.text = student.studentName
        guard let color = StudentIcon(rawValue: student.studentIcon)?.textColor else { return }
        weekCountLabel.textColor = color
        if student.weekCount == 1 {
            weekCountLabel.text = "매주"
        } else {
            weekCountLabel.text = "\(student.weekCount)주 마다"
        }
        iconImageView.image = StudentIcon(rawValue: student.studentIcon)?.selectedImage
        
        lessonTimeStackView.subviews.forEach { $0.removeFromSuperview() }
        
        student.lessonSchedules.forEach {
            let lessonTimeView = LessonTimeView(lessonSchedule: $0, color: color)
            lessonTimeStackView.addArrangedSubview(lessonTimeView)
            lessonTimeView.separatorView.snp.makeConstraints {
                $0.width.equalTo(stackView)
            }
        }
    }
    
}
