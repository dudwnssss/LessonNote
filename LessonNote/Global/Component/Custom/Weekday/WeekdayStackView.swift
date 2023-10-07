//
//  WeekdayStackView.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/04.
//

import UIKit

class WeekdayStackView: UIStackView{
    
    var selectedWeekdays: [Weekday] {
        var selectedDays: [Weekday] = []
        for (index, button) in weekdayButtons.enumerated() {
            if button.isActivated {
                selectedDays.append(weekdays[index])
            }
        }
        return selectedDays
    }
    
    let weekdays = Weekday.allCases
    var weekdayButtons: [CustomButton] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setProperties()
        setLayouts()
    }
    
    func setProperties() {
        weekdays.forEach {
            weekdayButtons.append(CustomButton(title: $0.title))
        }
        weekdayButtons.forEach {
            $0.titleLabel?.font = Font.medium14
        }
        axis = .horizontal
        spacing = 4
        distribution = .fillEqually
    }
    
    func setLayouts() {
        weekdayButtons.forEach {
            addArrangedSubviews($0)
            $0.snp.makeConstraints {
//                $0.width.equalTo(43.adjusted)
                $0.height.equalTo(33)
            }
        }
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
