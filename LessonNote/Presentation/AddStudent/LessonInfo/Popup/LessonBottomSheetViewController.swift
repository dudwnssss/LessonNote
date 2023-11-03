//
//  LessonBottomSheetViewController.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/13.
//

import UIKit


protocol PassLessonTimes: AnyObject {
    func passLessonTimes(lessons: [LessonTime])
}

final class LessonBottomSheetViewController: BaseViewController {
    
    weak var delegate: PassLessonTimes?
    private let lessonBottomSheetView = LessonBottomSheetView()
    let lessonBottomSheetViewModel = LessonBottomSheetViewModel()
    
    override func loadView() {
        self.view = lessonBottomSheetView
    }
    
    override func setProperties() {
        lessonBottomSheetView.weekdayStackView.configureStackView(weekdays: lessonBottomSheetViewModel.existWeekdays, hide: true)
        lessonBottomSheetView.addButton.addTarget(self, action: #selector(addButtonDidTap), for: .touchUpInside)
        lessonBottomSheetView.weekdayStackView.weekdayButtons.forEach {
            $0.addTarget(self, action: #selector(weekdayButtonDidTap(sender:)), for: .touchUpInside)
        }
        lessonBottomSheetView.startTimePickerView.addTarget(self, action: #selector(startTimeDidChange(sender:)), for: .valueChanged)
        lessonBottomSheetView.endTimePickerView.addTarget(self, action: #selector(endTimeDidChange(sender:)), for: .valueChanged)

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
    
    @objc func endTimeDidChange(sender: UIDatePicker) {
            let endTime = sender.date
            let startTime = lessonBottomSheetView.startTimePickerView.date
            lessonBottomSheetView.endTimePickerView.minimumDate = startTime
            if endTime < startTime {
                lessonBottomSheetView.endTimePickerView.date = startTime
            }
        }
}
