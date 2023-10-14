//
//  LessonBottomSheetView.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/13.
//

import UIKit

class LessonBottomSheetView: BaseView {
    
    private let weekdayLabel = UILabel()
    private let startTimeLabel = UILabel()
    private let endTimeLabel = UILabel()
    let addButton = UIButton()
    let weekdayStackView = WeekdayStackView()
    let startTimePickerView = UIDatePicker()
    let endTimePickerView = UIDatePicker()
    
    let startStackView = UIStackView()
    let endStackView = UIStackView()
    let horizontalStackView = UIStackView()
    
    override func setProperties() {
        addButton.do {
            $0.setTitle("수업 추가", for: .normal)
            $0.setTitleColor(Color.white, for: .normal)
            $0.titleLabel?.font = Font.bold14
            $0.cornerRadius = 10
            $0.backgroundColor = Color.gray6
        }
        weekdayLabel.do {
            $0.text = "수업 요일"
            $0.font = Font.bold14
        }
        startTimeLabel.do {
            $0.text = "시작 시간"
            $0.font = Font.bold14
        }
        endTimeLabel.do {
            $0.text = "종료 시간"
            $0.font = Font.bold14
        }
        startTimePickerView.do {
            $0.preferredDatePickerStyle = .wheels
            $0.locale = Locale(identifier: "ko_KR")
            $0.datePickerMode = .time
            $0.backgroundColor = Color.gray1
            $0.cornerRadius = 20
            $0.setDefaultTime(hour: 9)
            
        }
        endTimePickerView.do {
            $0.preferredDatePickerStyle = .wheels
            $0.datePickerMode = .time
            $0.locale = Locale(identifier: "ko_KR")
            $0.backgroundColor = Color.gray1
            $0.cornerRadius = 20
            $0.setDefaultTime(hour: 10)
        }
        
    }
    
    override func setLayouts() {
        addSubviews(addButton, weekdayLabel, weekdayStackView, startTimeLabel, startTimePickerView, endTimeLabel, endTimePickerView)
        addButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-25)
            $0.top.equalToSuperview().offset(21)
            $0.height.equalTo(30)
            $0.width.equalTo(68)
        }
        weekdayLabel.snp.makeConstraints {
            $0.top.equalTo(addButton.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(25)
            $0.height.equalTo(17)
        }
        weekdayStackView.snp.makeConstraints {
            $0.top.equalTo(weekdayLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(25)
        }
        startTimeLabel.snp.makeConstraints {
            $0.leading.equalTo(weekdayLabel)
            $0.top.equalTo(weekdayStackView.snp.bottom).offset(32)
            $0.height.equalTo(17)
        }
        startTimePickerView.snp.makeConstraints {
            $0.leading.equalTo(weekdayLabel)
            $0.top.equalTo(startTimeLabel.snp.bottom).offset(16)
            $0.width.equalTo(160)
            $0.height.equalTo(124)
        }
        endTimeLabel.snp.makeConstraints {
            $0.leading.equalTo(endTimePickerView)
            $0.top.equalTo(weekdayStackView.snp.bottom).offset(32)
            $0.height.equalTo(17)
        }
        endTimePickerView.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-25)
            $0.top.equalTo(startTimeLabel.snp.bottom).offset(16)
            $0.width.equalTo(160)
            $0.height.equalTo(124)
        }
    }
}

extension UIDatePicker {
    func setDefaultTime(hour: Int){
        let calendar = Calendar.current
        var components = DateComponents()
        components.hour = hour
        components.minute = 0
        if let defaultDate = calendar.date(from: components) {
            date = defaultDate
        }
    }
}
