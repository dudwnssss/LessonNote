//
//  StudentCollectionViewCell.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/01.
//

import UIKit

final class StudentCollectionViewCell: UICollectionViewCell {
        
    let iconImageView = UIImageView()
    let nameLabel = UILabel()
    let studentLabel = UILabel()
    let weekCountLabel = UILabel()
    private let separatorView = SeparatorView(color: Color.gray1)
    private let lessonTimeStackView = UIStackView()
    private let punchImageView = UIImageView()
    private let cellBackgroundView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setProperties()
        setLayouts()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        print("prepare reuse")
        for arrangedSubview in lessonTimeStackView.arrangedSubviews {
              lessonTimeStackView.removeArrangedSubview(arrangedSubview)
              arrangedSubview.removeFromSuperview()
          }
    }
    
    private func setProperties() {
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
            $0.alignment = .leading
        }


    }
    
    private func setLayouts() {
        addSubviews(punchImageView, cellBackgroundView)
        punchImageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
        }
        cellBackgroundView.snp.makeConstraints {
            $0.top.equalTo(punchImageView.snp.bottom)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
        cellBackgroundView.addSubviews(iconImageView, nameLabel, studentLabel, separatorView, lessonTimeStackView, weekCountLabel)
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
            $0.width.equalTo(25)
            $0.trailing.lessThanOrEqualTo(weekCountLabel.snp.leading).offset(-4)
        }
        separatorView.snp.makeConstraints {
            $0.leading.equalTo(nameLabel)
            $0.width.equalTo(190.adjusted)
            $0.top.equalTo(nameLabel.snp.bottom).offset(4)
        }
        weekCountLabel.snp.makeConstraints {
            $0.trailing.equalTo(separatorView)
            $0.bottom.equalTo(nameLabel)
        }
        lessonTimeStackView.snp.makeConstraints {
            $0.top.equalTo(separatorView.snp.bottom)
            $0.bottom.equalToSuperview().offset(-25)
            $0.horizontalEdges.equalTo(separatorView)
        }
    }
    
    func configureCell(student: Student){
        nameLabel.text = student.studentName
        guard let color = StudentIcon(rawValue: student.studentIcon)?.textColor else { return }
        weekCountLabel.textColor = color
        if student.weekCount == 1 {
            weekCountLabel.text = "매주"
        } else {
            weekCountLabel.text = "\(student.weekCount)주 마다"
        }
        iconImageView.image = StudentIcon(rawValue: student.studentIcon)?.image
        student.lessonSchedules.forEach {
            let lessonTimeView = LessonTimeView(lessonSchedule: $0, color: color)
            lessonTimeStackView.addArrangedSubview(lessonTimeView)
        }
    }
    


    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
