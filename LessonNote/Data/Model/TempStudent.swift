//
//  StudentRegisterManager.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/05.
//

import Foundation

class TempStudent {
    private init(){}
    static let shared = TempStudent()
    
    var studentName: String?
    var studentIcon: StudentIcon?
    var studentPhoneNumber: String?
    var parentPhoneNumber: String?
    var lessonTimes: [LessonTime]?
    var lessonStartDate: Date?
    var weekCount: Int?
    
    func createStudent() -> Student? {
        guard let studentName = self.studentName,
              let studentIcon = self.studentIcon else {
            return nil
        }
        let student = Student(studentName: studentName,
                              studentIcon: studentIcon.rawValue,
                              studentPhoneNumber: self.studentPhoneNumber,
                              parentPhoneNumber: self.parentPhoneNumber,
                              lessonStartDate: self.lessonStartDate,
                              weekCount: self.weekCount)
        return student
    }
}
