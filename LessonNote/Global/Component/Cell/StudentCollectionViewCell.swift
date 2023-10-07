//
//  StudentCollectionViewCell.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/01.
//

import UIKit

class StudentCollectionViewCell: UICollectionViewCell {
    
    //Studnet Table
    
    let iconImageView = UIImageView()
    let nameLabel = UILabel()
    let studentLabel = UILabel()
    let separatorView = SeparatorView(color: Color.gray1)
    let lessonTimeStackView = UIStackView()
    let punchImageView = UIImageView()
    let cellBackgroundView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setProperties()
        setLayouts()
    }
    
    func setProperties() {
        punchImageView.do {
            $0.image = Image.notePunched
            $0.contentMode = .scaleAspectFill
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


    }
    
    func setLayouts() {
        addSubviews(punchImageView, cellBackgroundView)
        punchImageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
        }
        cellBackgroundView.snp.makeConstraints {
            $0.top.equalTo(punchImageView.snp.bottom)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
        cellBackgroundView.addSubviews(iconImageView, nameLabel, studentLabel, separatorView, lessonTimeStackView)
        iconImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.leading.equalToSuperview().offset(18)
            $0.size.equalTo(65)
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
            $0.width.equalTo(190.adjusted)
            $0.top.equalTo(nameLabel.snp.bottom).offset(4)
        }
        lessonTimeStackView.snp.makeConstraints {
            $0.top.equalTo(separatorView.snp.bottom)
            $0.bottom.equalToSuperview().offset(-25)
            $0.horizontalEdges.equalTo(separatorView)
        }
    }
    
    func configureCell(student: Student){
        nameLabel.text = student.studentName
        iconImageView.image = StudentIcon(rawValue: student.studentIcon)?.image
        student.lessonSchedules.forEach {
            let lessonTimeView = LessonTimeView(lessonSchedule: $0, color: StudentIcon(rawValue: student.studentIcon)!.color)
            lessonTimeStackView.addArrangedSubview(lessonTimeView)
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
