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
    var weekCount: Int = 1
    var studentPhoneNumber: String?
    var parentPhoneNumber: String?
    var lessonSchedules: LessonSchedule?
}
