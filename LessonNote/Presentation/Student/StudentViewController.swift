//
//  StudentViewController.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/10.
//

import UIKit
import FSCalendar

final class StudentViewController: BaseViewController {
    
    var student: Student?
    
    private let studentView = StudentView()
    private lazy var studentViewModel = StudentViewModel(student: student!)
    
    override func loadView() {
        self.view = studentView
    }
    
    override func setProperties() {
        view.backgroundColor = Color.gray1
        if let student {
            studentView.customStudentView.configureView(student: student)
        }
        studentView.calendarView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.studentIcon = StudentIcon(rawValue: student!.studentIcon)!
        }
        studentViewModel.scheduledLessonDates.bind { _ in
            self.studentView.calendarView.reloadData()
        }

    }
}

extension StudentViewController: FSCalendarDelegate, FSCalendarDataSource {
    func minimumDate(for calendar: FSCalendar) -> Date {
        guard let student, let startDate = student.lessonStartDate else {
            return Date()
        }
        return startDate
    }
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        if studentViewModel.scheduledLessonDates.value.contains(date){
            return 1
        } else {
            return 0
        }
    }
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        return nil
    }

    
}
