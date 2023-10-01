//
//  Student.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/02.
//

import Foundation
import RealmSwift





class Student: Object{
    
    @Persisted(primaryKey: true) var studentID: ObjectId
    @Persisted var studentName: String
    @Persisted var studentIcon: StudentIcon.RawValue
    @Persisted var studentPhoneNumber: String?
    @Persisted var parentPhoneNumber: String?
    @Persisted var memo: String?
    
    convenience init(studentName: String, studentIcon: StudentIcon.RawValue, studentPhoneNumber: String? = nil, parentPhoneNumber: String? = nil, memo: String? = nil) {
        self.init()
        self.studentName = studentName
        self.studentIcon = studentIcon
        self.studentPhoneNumber = studentPhoneNumber
        self.parentPhoneNumber = parentPhoneNumber
        self.memo = memo
    }
}

class LessonSchedule: Object {
    @Persisted var weekday: Int
    @Persisted var startTime: Date
    @Persisted var endTime: Date
}
