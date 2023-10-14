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
    let addButton = CustomButton(title: "추가")
    let weekdayStackView = WeekdayStackView()
    
    override func setProperties() {
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
    }
    
    override func setLayouts() {
        addButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-25)
            $0.top.equalToSuperview().offset(-30)
        }
        weekdayLabel.snp.makeConstraints {
            $0.top.equalTo(addButton.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(25)
        }
        weekdayStackView.snp.makeConstraints {
            $0.top.equalTo(weekdayLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(25)
        }
    }
}
