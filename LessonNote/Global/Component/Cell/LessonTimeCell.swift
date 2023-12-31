//
//  LessonTimeCell.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/05.
//

import UIKit

final class LessonTimeCell: UICollectionViewCell{
    let scheduleLabel = UILabel()
    private let deleteButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setProperties()
        setLayouts()
    }

    func configureCell(lessonTime: LessonTime){
        scheduleLabel.text = lessonTime.weekday.title + " " +  DateManager.shared.buildTimeRangeString(startDate: lessonTime.startTime, endDate: lessonTime.endTime)
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LessonTimeCell {
    private func setProperties() {
        scheduleLabel.do {
            $0.text = "화 10:00 - 12:00"
            $0.font = Font.medium12
            $0.textColor = Color.white
        }
        deleteButton.do {
            $0.setImage(Image.dismissSmall, for: .normal)
        }
        backgroundColor = Color.gray6
        cornerRadius = 15
    }
    
    private func setLayouts() {
        addSubviews(scheduleLabel, deleteButton)
        scheduleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.centerY.equalToSuperview()
        }
        deleteButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-10)
            $0.centerY.equalTo(scheduleLabel)
        }
    }
}
