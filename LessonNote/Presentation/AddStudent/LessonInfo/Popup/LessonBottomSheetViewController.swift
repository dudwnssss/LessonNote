//
//  LessonBottomSheetViewController.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/13.
//

import UIKit

protocol PassLessonTimes {
    func passLessonTimes(lessons: [LessonTime])
}

final class LessonBottomSheetViewController: BaseViewController {
    
    private let lessonBottomSheetView = LessonBottomSheetView()
    let lessonBottomSheetViewModel = LessonBottomSheetViewModel()
    var delegate: PassLessonTimes?
    
    override func loadView() {
        self.view = lessonBottomSheetView
    }
    
    override func setProperties() {
        lessonBottomSheetViewModel.existWeekdays.forEach { weekday in
            lessonBottomSheetView.weekdayStackView.weekdayButtons[weekday.rawValue].isHidden = true
        }
        lessonBottomSheetView.addButton.addTarget(self, action: #selector(addButtonDidTap), for: .touchUpInside)
        lessonBottomSheetView.weekdayStackView.weekdayButtons.forEach {
            $0.addTarget(self, action: #selector(weekdayButtonDidTap(sender:)), for: .touchUpInside)
        }
        lessonBottomSheetView.startTimePickerView.addTarget(self, action: #selector(startTimeDidChange(sender:)), for: .valueChanged)
    }
    
    override func bind() {
        lessonBottomSheetViewModel.weekDays.bind { weekdays in
            self.lessonBottomSheetView.weekdayStackView.weekdayButtons.forEach {
                guard let weekday = Weekday(rawValue: $0.tag) else {return}
                $0.configureButton(activate: (weekdays.contains(weekday)))
            }
        }
    }
    
    @objc func addButtonDidTap(){
        let startTime = lessonBottomSheetView.startTimePickerView.date
        let endTime = lessonBottomSheetView.endTimePickerView.date
        delegate?.passLessonTimes(lessons: lessonBottomSheetViewModel.createLessonTime(startTime: startTime, endTime: endTime))
        dismiss(animated: true)
    }
    
    @objc func weekdayButtonDidTap(sender: CustomButton){
        lessonBottomSheetViewModel.appendWeekday(tag: sender.tag)
    }
    
    @objc func startTimeDidChange(sender: UIDatePicker) {
            let startTime = sender.date
            let endTime = lessonBottomSheetView.endTimePickerView.date
            lessonBottomSheetView.endTimePickerView.minimumDate = startTime
            if endTime < startTime {
                lessonBottomSheetView.endTimePickerView.date = startTime
            }
        }
}