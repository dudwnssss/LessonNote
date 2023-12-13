//
//  StudentViewController.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/10.
//

import UIKit

import FSCalendar
import RxCocoa
import RxSwift
import Toast

final class StudentViewController: BaseViewController {
    
    private let studentView = StudentView()
    let studentViewModel: StudentViewModel
    private let UpdateStudentTrigger = PublishSubject<Void>()
    private let disposeBag = DisposeBag()
    
    init(studentViewModel: StudentViewModel) {
        self.studentViewModel = studentViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        self.view = studentView
    }
    
    override func setNavigationBar() {
        navigationItem.title = "학생 정보"
        let setting = UIBarButtonItem(image: Image.edit, style: .plain, target: self, action: #selector(editButtonDidTap))
        navigationItem.rightBarButtonItems = [setting]
    }
    
    override func setProperties() {
        view.backgroundColor = Color.gray1
        let student = studentViewModel.student
        studentView.customStudentView.configureView(student: student)
        studentView.calendarView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.configureStudentCalendar(studentIcon: StudentIcon(rawValue: student.studentIcon)!)
        }
        setupMenu(type: .student)
        setupMenu(type: .parent)
    }
    
    override func bind() {
        
        let input = StudentViewModel.Input(updateStudent: UpdateStudentTrigger.asObservable())
        let output = studentViewModel.transform(input: input)
        
        output.configureStudent.bind(with: self) { owner, student in
            guard let icon = StudentIcon(rawValue: student.studentIcon) else { return }
            owner.setupMenu(type: .student)
            owner.setupMenu(type: .parent)
            owner.studentView.configureStudentView(student: student)
            owner.studentView.calendarView.configureStudentCalendar(studentIcon: icon)
            owner.studentView.calendarView.reloadData()
            }
        .disposed(by: disposeBag)
        
        output.setCalendarSchedule.bind(with: self) { owner, _ in
            owner.studentView.calendarView.reloadData()
        }
        .disposed(by: disposeBag)
    
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
            guard let studentPhoneNumber = studentViewModel.student.studentPhoneNumber else { studentButton.addTarget(self, action: #selector(presentAlert), for: .touchUpInside)
                return}
            if studentPhoneNumber == "" {
                studentButton.addTarget(self, action: #selector(presentAlert), for: .touchUpInside)
                return}
            phoneNumber = studentPhoneNumber
            button = studentButton
        case .parent:
            let parentButton = studentView.customStudentView.parentPhoneNumberButton
            guard let parentPhoneNumber = studentViewModel.student.parentPhoneNumber else {
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
        let message = UIAction(title: "피드백 문자 보내기", image: Image.messageLong) { [weak self] _ in
            let vm = MessageViewModel(personType: type, student: (self?.studentViewModel.student)!)
            let vc = MessageViewController(viewModel: vm)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        let menuItems = [call, message]
        let menu = UIMenu(title: phoneNumber.withHypen, children: menuItems)
        menu.preferredElementSize = .medium
        button.menu = menu
        button.showsMenuAsPrimaryAction = true
    }
    
    @objc func editButtonDidTap(){
        let vc = StudentEditViewController()
        vc.viewModel.student.value = studentViewModel.student
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
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StudentViewController: FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        return studentViewModel.scheduledLessonDates.last ?? DateManager.shared.hundredYearFromToday()
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendar.snp.updateConstraints { (make) in
            make.height.equalTo(bounds.height)
        }
        self.view.layoutIfNeeded()
    }
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        let student = studentViewModel.student
        guard let startDate = student.lessonStartDate else {
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
        let startDate = studentViewModel.student.lessonStartDate ?? Date()
        if DateManager.shared.isDate(date, before: startDate) {
            return 0
        }
        //수업 없음 적용하기
        let lessons = studentViewModel.student.lessons
        for item in lessons {
            if date == item.date{
                if let stateRawValue = item.lessonState, let state = LessonState(rawValue: stateRawValue) {
                    if state == .none {
                        return 0
                    }
                }
            }
        }
        
        if studentViewModel.scheduledLessonDates.contains(where: { DateManager.shared.areDatesEqualIgnoringTime(date1: $0, date2: date) }) {
            return 1
        } else {
            return 0
        }
    }
    
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        guard let startDate = studentViewModel.student.lessonStartDate else {return nil}
        if DateManager.shared.isDate(date, before: startDate) {
            return nil
        }
        let lessons = studentViewModel.student.lessons
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
        let lessons = studentViewModel.student.lessons
        for item in lessons {
            if date == item.date{
                guard let stateRawValue = item.lessonState, let state = LessonState(rawValue: stateRawValue) else {return nil}
                switch state {
                case .completed, .supplemented:
                     let icon = studentViewModel.student.studentIcon
                    guard let color = StudentIcon(rawValue: icon)?.textColor else {return nil}
                    return color
                    
                case .canceled, .none:
                    return Color.gray4
                }
            }
        }
        return nil
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, subtitleSelectionColorFor date: Date) -> UIColor? {
        let lessons = studentViewModel.student.lessons
        for item in lessons {
            if date == item.date{
                guard let stateRawValue = item.lessonState, let state = LessonState(rawValue: stateRawValue) else {return nil}
                switch state {
                case .completed, .supplemented:
                    let icon = studentViewModel.student.studentIcon
                    guard let color = StudentIcon(rawValue: icon)?.textColor else {return nil}
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
        
        vc.viewModel.student = studentViewModel.student
        vc.viewModel.date = date
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

extension StudentViewController: UpdateStudentDelegate {
    func updateStudent() {
        UpdateStudentTrigger.onNext(())
    }
}
