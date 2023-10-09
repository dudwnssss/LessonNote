//
//  ScheduleViewModel.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/09.
//

import Foundation
import RealmSwift

class ScheduleViewModel{
    
    private let repository = StudentRepository()
    private var studentResults: Results<Student>! // realm기반, 변경 시 list에 값 전달
    private var notificationToken: NotificationToken?
    
    var courseItems: Observable<[ElliottEvent]> = Observable([])
    var daysOfWeek = DateManager.shared.getDatesForWeek(numberOfWeeksFromThisWeek: 0)
    
    
    //헤더에 표시용
    var dateRangeOfWeek = DateManager.shared.getDateRange(numberOfWeeksFromThisWeek: 0)
    
    init(){
        studentResults = repository.fetch()
        setCourseItems()
        notificationToken = studentResults.observe { [weak self] (changes: RealmCollectionChange) in
            switch changes {
            case .initial:
                break
            case .update(_, _, _, _):
                self?.setCourseItems()
                break
            case .error(let error):
                print(error)
                break
            }
        }
    }
    
    func setCourseItems(){
        studentResults.forEach { student in
            student.toElliotEvent().forEach { event in
                courseItems.value.append(event)
            }
        }
    }
    
    deinit {
           notificationToken?.invalidate()
       }
}
