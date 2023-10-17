//
//  StartDateInfoViewController.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/05.
//

import UIKit
import FSCalendar

final class StartDateInfoViewController: BaseViewController{
    
    var selectedDate: Date?{
        didSet{
            TempStudent.shared.lessonStartDate = selectedDate
        }
    }
    
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

        hideKeyboardWhenTappedAround()
        startDateInfoView.nextButton.addTarget(self, action: #selector(nextButtonDidTap), for: .touchUpInside)
        startDateInfoViewModel.isValid.bind { [weak self] value in
            self?.startDateInfoView.nextButton.isActivated = value
        }
    }
    
    @objc func nextButtonDidTap(){
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
        selectedDate = date
        startDateInfoViewModel.isValid.value = true
    }
}
