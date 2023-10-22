//
//  ScheduleViewModel.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/09.
//

import Foundation
import RealmSwift

final class ScheduleViewModel{
    
    private let repository = StudentRepository()
    private var studentResults: Results<Student>! // realm기반, 변경 시 list에 값 전달
    private var notificationToken: NotificationToken?
    
    var daysOfWeek = DateManager.shared.getDatesForWeek(numberOfWeeksFromThisWeek: 0)
        
    var weekSchedules: Observable<[[ElliottEvent]]> = Observable([])
    
    //헤더에 표시용
    var dateRangeOfWeek = DateManager.shared.getDateRange(numberOfWeeksFromThisWeek: 0)

    init(){
        studentResults = repository.fetch()
        for i in 0...7 {
            setCourseItems(week: i)
        }
        notificationToken = studentResults.observe { [weak self] (changes: RealmCollectionChange) in
            switch changes {
            case .initial:
                break
            case .update(_, _, _, _):
                self?.weekSchedules.value.removeAll()
                for i in 0...7 {
                    self?.setCourseItems(week: i)
                }
                break
            case .error(let error):
                print(error)
                break
            }
        }
    }
    
    func createYearlyLessonSchedule(student: Student) -> [Date]{
        let weekdays = student.lessonSchedules.map { $0.weekday }
        let weekCount = student.weekCount
        let startWeekday = student.startWeekday
        let startDate = student.lessonStartDate
        let weekdaysArray = Array(weekdays)
        let dates = DateManager.shared.generateYearlyLessonSchedule(weekday: weekdaysArray, weekCount: weekCount, startWeekday: startWeekday, startDate: startDate!)
        return dates
    }
    
    
    
    func setCourseItems(week: Int){
        var weekSchedule: [ElliottEvent] = []
        studentResults.forEach { student in
            let yearlyLessonSchedule = createYearlyLessonSchedule(student: student)
            let yearlyLessonExists = DateManager.shared.generateWeeksArray(from: yearlyLessonSchedule)
            student.toElliotEvent(visibiliyList: yearlyLessonExists[week]).forEach { event in
                weekSchedule.append(event)
            }
        }
        weekSchedules.value.append(weekSchedule)
    }
    
    deinit {
           notificationToken?.invalidate()
       }
}
