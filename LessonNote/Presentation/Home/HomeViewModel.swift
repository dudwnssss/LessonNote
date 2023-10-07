//
//  HomeViewModel.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/02.
//

import Foundation
import RealmSwift

class HomeViewModel{
    
    private let repository = StudentRepository()
//    let realm = try! Realm()
    
//    let lessonSchedule1 = LessonTime(weekday: Weekday.monday.rawValue, startTime: Date(), endTime: Date())
    
    lazy var studentResults = repository.fetch()
    lazy var studentList = Array(studentResults)
//    let student1 = Student(studentName: "안소은", studentIcon: StudentIcon.pink.rawValue)
//
//    var studentList: [Student] = [Student(studentName: "안소은", studentIcon: StudentIcon.yellow.rawValue), Student(studentName: "임영준", studentIcon: StudentIcon.blue.rawValue)]
    
}
