//
//  WeekdayStackView.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/04.
//

import UIKit

final class WeekdayStackView: UIStackView{
    
    private let weekdays = Weekday.allCases
    var weekdayButtons: [CustomButton] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setProperties()
        setLayouts()
    }
    
    private func setProperties() {
        weekdays.forEach {
            let button = CustomButton(title: $0.title)
            button.tag = $0.rawValue
            weekdayButtons.append(button)
        }
        weekdayButtons.forEach {
            $0.titleLabel?.font = Font.medium14
        }
        axis = .horizontal
        spacing = 4
        distribution = .fillEqually
    }
    
    private func setLayouts() {
        weekdayButtons.forEach {
            addArrangedSubviews($0)
            $0.snp.makeConstraints {
                $0.height.equalTo(33)
            }
        }
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
