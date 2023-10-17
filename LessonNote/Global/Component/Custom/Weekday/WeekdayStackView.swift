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
            button.snp.makeConstraints {
                $0.width.equalTo(44)
            }
            weekdayButtons.append(button)
        }
        weekdayButtons.forEach {
            $0.titleLabel?.font = Font.medium14
        }
        axis = .horizontal
        distribution = .fillEqually
        spacing = 4
    }
    
    private func setLayouts() {
        weekdayButtons.forEach {
            addArrangedSubviews($0)
            $0.snp.makeConstraints {
                $0.height.equalTo(33)
            }
        }
    }
    
    func configureStackView(weekdays: [Weekday], hide: Bool){
        if hide {
            weekdays.forEach { weekday in
                weekdayButtons[weekday.rawValue].isHidden = true
            }
        } else {
            weekdayButtons.forEach { button in
                button.isHidden = true
            }
            weekdays.forEach { weekday in
                weekdayButtons[weekday.rawValue].isHidden = false
            }
        }
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
