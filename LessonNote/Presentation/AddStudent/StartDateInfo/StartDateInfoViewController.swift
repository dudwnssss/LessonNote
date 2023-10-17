//
//  StartDateInfoViewController.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/05.
//

import UIKit
import FSCalendar

final class StartDateInfoViewController: BaseViewController{
    
    private let startDateInfoView = StartDateInfoView()
    private let startDateInfoViewModel = StartDateInfoViewModel()
    
    override func loadView() {
        self.view = startDateInfoView
    }
    
    override func setNavigationBar() {
        navigationItem.title = "학생 추가"
    }
    
    override func setProperties() {
        startDateInfoView.calendar.do {
            $0.delegate = self
            $0.dataSource = self
            $0.configureCalendar(studentIcon: TempStudent.shared.studentIcon!)
        }
        startDateInfoView.nextButton.addTarget(self, action: #selector(nextButtonDidTap), for: .touchUpInside)
        startDateInfoView.startWeekdayView.weekdayStackView.configureStackView(weekdays: startDateInfoViewModel.weekdays, hide: false)
        startDateInfoView.startWeekdayView.weekdayStackView.weekdayButtons.forEach { button in
            button.addTarget(self, action: #selector(weekdayButtonDidTap(sender:)), for: .touchUpInside)
        }
    }
    
    override func bind() {
        startDateInfoViewModel.isValid.bind { [weak self] value in
            self?.startDateInfoView.nextButton.isActivated = value
        }
        startDateInfoViewModel.weekday.bind { weekday in
            self.startDateInfoView.startWeekdayView.descriptionLabel.text = weekday.title+"요일을 기준으로 주차가 반복됩니다."
            self.startDateInfoView.startWeekdayView.weekdayStackView.weekdayButtons.forEach { button in
                print(button)
                button.configureButton(activate: button.tag == weekday.rawValue)
            }
        }
    }
    
    @objc func weekdayButtonDidTap(sender: CustomButton) {
        print(#fileID, #function, #line, "- ") 
        startDateInfoViewModel.weekday.value = Weekday(rawValue: sender.tag)!
    }
    
    @objc func nextButtonDidTap(){
        startDateInfoViewModel.storeData()
        let vc = CheckInfoViewController() 
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension StartDateInfoViewController: FSCalendarDelegate, FSCalendarDataSource{
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
//    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
//        let calendar = Calendar.current
//        let weekday = calendar.component(.weekday, from: date)
//        if weekday == 2 || weekday == 4 || weekday == 6 {
//            return true
//        }
//        return false
//    }
//    
//    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
//        let calendar = Calendar.current
//        let weekday = calendar.component(.weekday, from: date)
//        if weekday == 2 || weekday == 4 || weekday == 6 {
//            return nil
//        }
//        return .gray
//    }
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        startDateInfoViewModel.date.value = date
        startDateInfoViewModel.isValid.value = true
    }
}
