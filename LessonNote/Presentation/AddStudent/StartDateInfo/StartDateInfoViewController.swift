//
//  StartDateInfoViewController.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/05.
//

import UIKit
import FSCalendar

class StartDateInfoViewController: BaseViewController{
    
    var selectedDate: Date?{
        didSet{
            TempStudent.shared.lessonStartDate = selectedDate
        }
    }
    
    let startDateInfoView = StartDateInfoView()
    
    override func loadView() {
        self.view = startDateInfoView
    }
    
    override func setNavigationBar() {
        navigationItem.title = "학생 추가"
    }
    
    override func setProperties() {
        startDateInfoView.calendar.delegate = self
        hideKeyboardWhenTappedAround()
        startDateInfoView.nextButton.addTarget(self, action: #selector(nextButtonDidTap), for: .touchUpInside)
    }
    
    @objc func nextButtonDidTap(){
        let vc = CheckInfoViewController() 
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension StartDateInfoViewController: FSCalendarDelegate{
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        selectedDate = date
        print(selectedDate)
    }
}
