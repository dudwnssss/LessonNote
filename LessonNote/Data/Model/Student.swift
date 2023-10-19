//
//  Student.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/02.
//

import Foundation
import RealmSwift

final class Student: Object {
    
    @Persisted(primaryKey: true) var studentId: ObjectId
    @Persisted var studentName: String
    @Persisted var studentIcon: StudentIcon.RawValue
    @Persisted var studentPhoneNumber: String?
    @Persisted var parentPhoneNumber: String?
    @Persisted var lessonSchedules: List<LessonSchedule>
    @Persisted var lessonStartDate: Date?
    @Persisted var weekCount: Int
    @Persisted var memo: String?
    @Persisted var lessons: List<Lesson>
    @Persisted var startWeekday: Weekday.RawValue
    
    
    convenience init(studentName: String, studentIcon: StudentIcon.RawValue, studentPhoneNumber: String? = nil, parentPhoneNumber: String? = nil, lessonStartDate: Date? = nil, weekCount: Int = 1, startWeekday: Weekday.RawValue) {
        self.init()
        self.studentName = studentName
        self.studentIcon = studentIcon
        self.studentPhoneNumber = studentPhoneNumber
        self.parentPhoneNumber = parentPhoneNumber
        self.lessonStartDate = lessonStartDate
        self.weekCount = weekCount
        self.startWeekday = startWeekday
    }
    
    func toElliotEvent() -> [ElliottEvent] {
        var events:[ElliottEvent] = []
        for item in lessonSchedules{
            let event = ElliottEvent(courseId: "123",
                                     courseName: studentName,
                                     roomName: "123",
                                     courseDay: ElliotDay(rawValue: item.weekday)!,
                                     startTime: DateManager.shared.formatTime(from: item.startTime),
                                     endTime: DateManager.shared.formatTime(from: item.endTime),
                                     backgroundColor: StudentIcon(rawValue: studentIcon)!.color,
                                     student: self)
            events.append(event)
        }
        return events
    }
}

final class LessonSchedule: Object {
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

extension LessonSchedule {
    func toLessonTime() -> LessonTime {
        let lessonTime = LessonTime(weekday: Weekday(rawValue: self.weekday)!, startTime: startTime, endTime: endTime)
        return lessonTime
    }
}

final class Lesson: Object {
    @Persisted var id: UUID
    @Persisted var date: Date?
    @Persisted var lessonState: LessonState.RawValue?
    @Persisted var assignmentState: AssignmentState.RawValue?
    @Persisted var feedback: String?
    @Persisted(originProperty: "lessons") var student: LinkingObjects<Student>
    
    convenience init(date: Date? = nil, lessonState: LessonState.RawValue? = nil, assignmentState: AssignmentState.RawValue? = nil, feedback: String? = nil) {
        self.init()
        self.date = date
        self.lessonState = lessonState
        self.assignmentState = assignmentState
        self.feedback = feedback
    }
}
