//
//  StudentRegisterManager.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/05.
//

import Foundation

final class TempStudent {
    private init(){}
    static let shared = TempStudent()
    
    var studentName: String?
    var studentIcon: StudentIcon?
    var studentPhoneNumber: String?
    var parentPhoneNumber: String?
    var lessonTimes: [LessonTime]?
    var lessonStartDate: Date?
    var weekCount: Int = 1
    var startWeekday: Weekday?
    
    func createStudent() -> Student? {
        guard let studentName = self.studentName,
              let studentIcon = self.studentIcon,
              let startWeekday = self.startWeekday else {
            return nil
        }
        let student = Student(studentName: studentName,
                              studentIcon: studentIcon.rawValue,
                              studentPhoneNumber: self.studentPhoneNumber,
                              parentPhoneNumber: self.parentPhoneNumber,
                              lessonStartDate: self.lessonStartDate,
                              weekCount: self.weekCount,
                              startWeekday: startWeekday.rawValue)
        return student
    }
}
