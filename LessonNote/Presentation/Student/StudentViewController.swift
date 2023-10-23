//
//  StudentViewController.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/10.
//

import UIKit
import FSCalendar
import Toast

enum PersonType {
    case student
    case parent
    
    var title: String {
        switch self {
        case .student:
            return "학생"
        case .parent:
            return "학부모"
        }
    }
}

final class StudentViewController: BaseViewController {
    
    private let studentView = StudentView()
    var studentViewModel = StudentViewModel()
    
    override func loadView() {
        self.view = studentView
    }
    
    override func setNavigationBar() {
        navigationItem.title = "학생 정보"
        //        let memo = UIBarButtonItem(image: Image.memo, style: .plain, target: self, action: nil)
        let setting = UIBarButtonItem(image: Image.setting, style: .plain, target: self, action: #selector(settingButtonDidTap))
        navigationItem.rightBarButtonItems = [setting]
    }
    
    override func setProperties() {
        view.backgroundColor = Color.gray1
        guard let student = studentViewModel.student.value else { return }
        studentView.customStudentView.configureView(student: student)
        studentView.calendarView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.configureStudentCalendar(studentIcon: StudentIcon(rawValue: student.studentIcon)!)
        }
        studentViewModel.scheduledLessonDates.bind { lessons in
            self.studentView.calendarView.reloadData()
        }
        setupMenu(type: .student)
        setupMenu(type: .parent)
        studentViewModel.setSchedule(student: student)
    }
    
    override func bind() {
        studentViewModel.student.bind { [weak self] student in
            guard let student, let icon = StudentIcon(rawValue: student.studentIcon) else {return}
            self?.setupMenu(type: .student)
            self?.setupMenu(type: .parent)
            self?.studentView.configureStudentView(student: student)
            self?.studentViewModel.setSchedule(student: student)
            self?.studentView.calendarView.configureStudentCalendar(studentIcon: icon)
            self?.studentView.calendarView.reloadData()
        }
    }
    
    @objc func presentAlert(){
        let alert = UIAlertController(title: "", message: "등록된 연락처가 없습니다\n'설정'에서 전화번호를 추가해주세요", preferredStyle: .alert)
        let confirm = UIAlertAction(title: "확인", style: .cancel)
        alert.addAction(confirm)
        present(alert, animated: true)
    }
    
    func setupMenu(type: PersonType) {
        var phoneNumber = ""
        var button = UIButton()
        
        switch type {
        case .student:
            let studentButton = studentView.customStudentView.studentPhoneNumberButton
            guard let studentPhoneNumber = studentViewModel.student.value?.studentPhoneNumber else { studentButton.addTarget(self, action: #selector(presentAlert), for: .touchUpInside)
                return}
            if studentPhoneNumber == "" {
                studentButton.addTarget(self, action: #selector(presentAlert), for: .touchUpInside)
                return}
            phoneNumber = studentPhoneNumber
            button = studentButton
        case .parent:
            let parentButton = studentView.customStudentView.parentPhoneNumberButton
            guard let parentPhoneNumber = studentViewModel.student.value?.parentPhoneNumber else {
                parentButton.addTarget(self, action: #selector(presentAlert), for: .touchUpInside)
                return}
            if parentPhoneNumber == "" {
                parentButton.addTarget(self, action: #selector(presentAlert), for: .touchUpInside)
                return}
            phoneNumber = parentPhoneNumber
            button = parentButton
        }
        
        let call = UIAction(title: "전화걸기", image: Image.phoneLong) { _ in
            if let url = NSURL(string: "tel://" + phoneNumber),
               UIApplication.shared.canOpenURL(url as URL) {
                UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
            }
        }
        let message = UIAction(title: "피드백 문자 보내기", image: Image.messageLong) { _ in
            let vc = MessageViewController()
            vc.messageViewModel.personType = type
            vc.messageViewModel.student = self.studentViewModel.student.value
            self.navigationController?.pushViewController(vc, animated: true)
        }
        let menuItems = [call, message]
        let menu = UIMenu(title: phoneNumber.withHypen, children: menuItems)
        menu.preferredElementSize = .medium
        button.menu = menu
        button.showsMenuAsPrimaryAction = true
    }
    
    @objc func settingButtonDidTap(){
        let vc = StudentEditViewController()
        vc.viewModel.student.value = studentViewModel.student.value
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func showToggle(text: String){
        var style = ToastStyle()
        style.messageFont = Font.medium14
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.view.makeToast(text, duration: 1.5, position: .top, style: style)
        }
        return
    }
    
}

extension StudentViewController: FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        return studentViewModel.scheduledLessonDates.value.last ?? DateManager.shared.oneYearFromToday()
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendar.snp.updateConstraints { (make) in
            make.height.equalTo(bounds.height)
        }
        self.view.layoutIfNeeded()
    }
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        guard let student = studentViewModel.student.value, let startDate = student.lessonStartDate else {
            return Date()
        }
        return startDate
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
        let currentDate = Calendar.current.startOfDay(for: Date())
        if date < currentDate {
            return [Color.gray3]
        } else {
            return nil
        }
    }
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventSelectionColorsFor date: Date) -> [UIColor]? {
        let currentDate = Calendar.current.startOfDay(for: Date())
        if date < currentDate {
            return [Color.gray3]
        } else {
            return nil
        }
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        
        //시작날짜 이전 없애기
        guard let startDate = studentViewModel.student.value?.lessonStartDate else {return 0}
        if date < startDate {
            return 0
        }
        
        //수업 없음 적용하기
        guard let lessons = studentViewModel.student.value?.lessons else { return 0 }
        for item in lessons {
            if date == item.date{
                if let stateRawValue = item.lessonState, let state = LessonState(rawValue: stateRawValue) {
                    if state == .none {
                        return 0
                    }
                }
            }
        }
        
        if studentViewModel.scheduledLessonDates.value.contains(where: { DateManager.shared.areDatesEqualIgnoringTime(date1: $0, date2: date) }) {
            return 1
        } else {
            return 0
        }
    }
    
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        guard let lessons = studentViewModel.student.value?.lessons else { return nil }
        for item in lessons {
            if date == item.date{
                guard let state = item.lessonState,
                      let stateString = LessonState(rawValue: state)?.calendarTitle else { return nil}
                return stateString
            }
        }
        return nil
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, subtitleDefaultColorFor date: Date) -> UIColor? {
        guard let lessons = studentViewModel.student.value?.lessons else { return nil }
        for item in lessons {
            if date == item.date{
                guard let stateRawValue = item.lessonState, let state = LessonState(rawValue: stateRawValue) else {return nil}
                switch state {
                case .completed, .supplemented:
                    guard let icon = studentViewModel.student.value?.studentIcon, let color = StudentIcon(rawValue: icon)?.textColor else {return nil}
                    return color
                    
                case .canceled, .none:
                    return Color.gray4
                }
            }
        }
        return nil
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, subtitleSelectionColorFor date: Date) -> UIColor? {
        guard let lessons = studentViewModel.student.value?.lessons else { return nil }
        for item in lessons {
            if date == item.date{
                guard let stateRawValue = item.lessonState, let state = LessonState(rawValue: stateRawValue) else {return nil}
                switch state {
                case .completed, .supplemented:
                    guard let icon = studentViewModel.student.value?.studentIcon, let color = StudentIcon(rawValue: icon)?.textColor else {return nil}
                    return color
                    
                case .canceled, .none:
                    return Color.gray4
                }
            }
        }
        return nil
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let vc = LessonViewController()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "M월 d일 E요일"
        let formattedDate = dateFormatter.string(from: date)
        
        vc.lessonViewModel.student = studentViewModel.student.value
        vc.lessonViewModel.date = date
        vc.navigationItem.title = formattedDate + " 수업"
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
        let calendarDate = DateManager.shared.formatFullDateToString(date: date)
        let todayDate = DateManager.shared.formatFullDateToString(date: Date())
        if calendarDate == todayDate{
            return "오늘"
        } else {
            return nil
        }
    }
}

extension StudentViewController: PassData {
    func passData() {
        studentViewModel.updateStudent()
        print(#fileID, #function, #line, "- ")
    }
}
