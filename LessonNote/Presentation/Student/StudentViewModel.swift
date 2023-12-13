//
//  StudentViewModel.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/10.
//

import Foundation

import RxSwift
import RxCocoa

final class StudentViewModel: ViewModelType {
    private let disposeBag = DisposeBag()
    private let repository = StudentRepository()
    var student: Student
    var scheduledLessonDates: [Date] {
        return setSchedule(student: student)
    }
    
    init(student: Student) {
        self.student = student
    }
    
    struct Input {
        let updateStudent: Observable<Void>
    }
    
    struct Output {
        let setCalendarSchedule = PublishRelay<[Date]>()
        let configureStudent = PublishRelay<Student>()
    }
    
    func transform(input: Input) -> Output {
        let output = Output()
        input.updateStudent
            .debug()
            .subscribe(with: self) { owner, _ in
                owner.updateStudent()
                output.configureStudent.accept(owner.student)
            }
            .disposed(by: disposeBag)
        output.setCalendarSchedule.accept(setSchedule(student: student))
        return output
    }
}

extension StudentViewModel {
    func setSchedule(student: Student) -> [Date] {
        let weekdays = student.lessonSchedules.map { $0.weekday }
        let weekCount = student.weekCount
        let startWeekday = student.startWeekday
        let startDate = student.lessonStartDate ?? Date()
        let weekdaysArray = Array(weekdays)
        let dates = DateManager.shared.generateYearlyLessonSchedule(weekday: weekdaysArray, weekCount: weekCount, startWeekday: startWeekday, startDate: startDate)
        return dates
    }
    
    func updateStudent(){
        guard let student = repository.fetchStudentById(student.studentId) else { return }
        self.student = student
    }
}

