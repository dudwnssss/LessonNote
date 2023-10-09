//
//  Student.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/02.
//

import Foundation
import RealmSwift

class Student: Object {
    
    @Persisted(primaryKey: true) var studentId: ObjectId
    @Persisted var studentName: String
    @Persisted var studentIcon: StudentIcon.RawValue
    @Persisted var studentPhoneNumber: String?
    @Persisted var parentPhoneNumber: String?
    @Persisted var lessonSchedules: List<LessonSchedule>
    @Persisted var lessonStartDate: Date?
    @Persisted var weekCount: Int?
    @Persisted var memo: String?
    
    
    convenience init(studentName: String, studentIcon: StudentIcon.RawValue, studentPhoneNumber: String? = nil, parentPhoneNumber: String? = nil, lessonStartDate: Date? = nil, weekCount: Int? = nil) {
        self.init()
        self.studentName = studentName
        self.studentIcon = studentIcon
        self.studentPhoneNumber = studentPhoneNumber
        self.parentPhoneNumber = parentPhoneNumber
        self.lessonStartDate = lessonStartDate
        self.weekCount = weekCount
    }
    
    func toElliotEvent() -> [ElliottEvent] {
        var events:[ElliottEvent] = []
        for item in lessonSchedules{
            let event = ElliottEvent(courseId: "123",
                                     courseName: studentName,
                                     roomName: "123",
                                     courseDay: ElliotDay(rawValue: item.weekday+1)!,
                                     startTime: DateManager.shared.formatTime(from: item.startTime),
                                     endTime: DateManager.shared.formatTime(from: item.endTime),
                                     backgroundColor: StudentIcon(rawValue: studentIcon)!.color,
                                     student: self)
            events.append(event)
        }
        return events
    }
}

class LessonSchedule: Object {
    @Persisted var weekday: Weekday.RawValue
    @Persisted var startTime: Date
    @Persisted var endTime: Date
    @Persisted(primaryKey: true) var lessonId: ObjectId
    @Persisted(originProperty: "lessonSchedules") var student: LinkingObjects<Student>

    convenience init(weekday: Weekday.RawValue, startTime: Date, endTime: Date) {
        self.init()
        self.weekday = weekday
        self.startTime = startTime
        self.endTime = endTime
    }
}
