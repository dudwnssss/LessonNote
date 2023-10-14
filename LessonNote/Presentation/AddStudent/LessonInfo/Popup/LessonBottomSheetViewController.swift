//
//  LessonBottomSheetViewController.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/13.
//

import UIKit

final class LessonBottomSheetViewController: BaseViewController {
    
    private let lessonBottomSheetView = LessonBottomSheetView()
    let lessonBottomSheetViewModel = LessonBottomSheetViewModel()
    
    override func loadView() {
        self.view = lessonBottomSheetView
    }
    
    override func setProperties() {
        lessonBottomSheetView.addButton.addTarget(self, action: #selector(addButtonDidTap), for: .touchUpInside)
        lessonBottomSheetView.weekdayStackView.weekdayButtons.forEach {
            $0.addTarget(self, action: #selector(weekdayButtonDidTap(sender:)), for: .touchUpInside)
        }
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
        dismiss(animated: true)
    }
    
    @objc func weekdayButtonDidTap(sender: CustomButton){
        lessonBottomSheetViewModel.appendWeekday(tag: sender.tag)
    }
    
    
}
