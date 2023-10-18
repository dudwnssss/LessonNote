//
//  CustomCheckInfoView.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/05.
//

import UIKit

final class CustomCheckInfoView: BaseView {
    
    private let punchImageView = UIImageView()
    let iconImageView = UIImageView()
    private let backgroundView = UIView()
    
    private let nameLabel = CustomCheckInfoLabel(title: "이름", content: TempStudent.shared.studentName!)
    private let studentPhoneNumberLabel = CustomCheckInfoLabel(title: "전화번호", content: TempStudent.shared.studentPhoneNumber!.withHypen)
    private let parentPhoneNumberLabel = CustomCheckInfoLabel(title: "학부모 전화번호", content: TempStudent.shared.parentPhoneNumber!.withHypen)
    
    let lessonTimeTitleLabel = UILabel()
    var lessonTimeLables: [UILabel] = []
    let lessonTimeStackView = UIStackView()
    
    private let weekCountLabel = CustomCheckInfoLabel(title: "격주 여부", content: "\(TempStudent.shared.weekCount)주 마다 수업")
    private let startDateLabel = CustomCheckInfoLabel(title: "수업 시작일 *", content: DateManager.shared.formatFullDateToString(date: TempStudent.shared.lessonStartDate ?? Date()))
    private let startWeekdayLabel = CustomCheckInfoLabel(title: "기준 요일", content: TempStudent.shared.startWeekday!.title+"요일")
    private let separator1 = SeparatorView(color: Color.gray1)
    private let separator2 = SeparatorView(color: Color.gray1)
    
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
        lessonTimeTitleLabel.do {
            let fullString = "수업 시간  |  "
            let attrString = NSMutableAttributedString(string: fullString)
            let range = (fullString as NSString).range(of: "수업 시간")
            attrString.addAttribute(.font, value: Font.bold14, range: range)
            $0.font = Font.medium14
            $0.attributedText = attrString
        }
        
        setLessonTimeStackView()
        lessonTimeStackView.do {
            $0.axis = .vertical
            $0.spacing = 4
            $0.alignment = .leading
        }

    }
    
    
    private func setLessonTimeStackView(){
        TempStudent.shared.lessonTimes?.forEach({ lessonTime in
            let lessonString = lessonTime.weekday.title+"요일 "+DateManager.shared.buildTimeRangeString(startDate: lessonTime.startTime, endDate: lessonTime.endTime)
            let label = UILabel()
            label.do {
                $0.text = lessonString
                $0.font = Font.medium14
            }
            lessonTimeStackView.addArrangedSubview(label)
        })
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
        backgroundView.addSubviews(iconImageView, nameLabel, studentPhoneNumberLabel, parentPhoneNumberLabel, weekCountLabel, startDateLabel, separator1, separator2, lessonTimeTitleLabel, lessonTimeStackView, weekCountLabel, startDateLabel, startWeekdayLabel)
        
        iconImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(20)
            $0.size.equalTo(65)
        }
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(iconImageView)
            $0.top.equalTo(iconImageView.snp.bottom).offset(16)
        }
        studentPhoneNumberLabel.snp.makeConstraints {
            $0.leading.equalTo(iconImageView)
            $0.top.equalTo(nameLabel.snp.bottom).offset(12)
        }
        parentPhoneNumberLabel.snp.makeConstraints {
            $0.leading.equalTo(iconImageView)
            $0.top.equalTo(studentPhoneNumberLabel.snp.bottom).offset(12)
        }
        separator1.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalTo(parentPhoneNumberLabel.snp.bottom).offset(16)
        }
        lessonTimeTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(iconImageView)
            $0.top.equalTo(separator1.snp.bottom).offset(16)
        }
        lessonTimeStackView.snp.makeConstraints {
            $0.leading.equalTo(lessonTimeTitleLabel.snp.trailing)
            $0.top.equalTo(lessonTimeTitleLabel)
            $0.trailing.equalToSuperview().offset(-20)
        }
        weekCountLabel.snp.makeConstraints {
            $0.leading.equalTo(iconImageView)
            $0.top.equalTo(lessonTimeStackView.snp.bottom).offset(12)
        }
        separator2.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalTo(weekCountLabel.snp.bottom).offset(16)
        }
        startDateLabel.snp.makeConstraints {
            $0.leading.equalTo(iconImageView)
            $0.top.equalTo(separator2.snp.bottom).offset(16)
        }
        startWeekdayLabel.snp.makeConstraints {
            $0.leading.equalTo(iconImageView)
            $0.top.equalTo(startDateLabel.snp.bottom).offset(16)
            $0.bottom.equalToSuperview().offset(-32)
        }
    }
}
