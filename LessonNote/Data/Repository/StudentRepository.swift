//
//  StudentRepository.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/03.
//

import Foundation
import RealmSwift

final class StudentRepository{
    
    private let realm = try! Realm()
    
    //학생 전체 불러오기
    func fetch() -> RealmSwift.Results<Student> {
        let data = realm.objects(Student.self)
        return data
    }
    
    //학생 한명 불러오기
    func fetchStudentById(_ studentId: ObjectId) -> Student? {
        let student = realm.object(ofType: Student.self, forPrimaryKey: studentId)
        return student
    }
    
    //학생 추가
    func create(_ item: Student) {
        do {
            try! realm.write{
                realm.add(item)
            }
        }
    }
    
    //학생 삭제
    func delete(_ item: Student) {
        do {
            try! realm.write{
                realm.delete(item)
            }
        }
    }
    
    //학생 업데이트
    func update( item: Student,
                 studentName: String,
                 studentIcon: StudentIcon,
                 studentPhoneNumber: String?,
                 parentPhoneNumber: String?,
                 lessonTimes: [LessonTime]?,
                 weekCount: Int,
                 lessonStartDate: Date,
                 startWeekday: Weekday
    ) {
        do {
            try! realm.write{
                item.studentName = studentName
                item.studentIcon = studentIcon.rawValue
                item.studentPhoneNumber = studentPhoneNumber
                item.parentPhoneNumber = parentPhoneNumber
                item.lessonSchedules.removeAll()
                lessonTimes?.forEach({ lessonTime in
                    item.lessonSchedules.append(lessonTime.toLessonSchedule())
                })
                item.weekCount = weekCount
                item.lessonStartDate = lessonStartDate
                item.startWeekday = startWeekday.rawValue
            }
        }
    }
    
    //수업 추가-갱신 (Upsert)
    
    func upsertLesson(student: Student, lesson: Lesson) {
        do {
            try! realm.write{
                for item in student.lessons{
                    if item.date == lesson.date{
                        item.feedback = lesson.feedback
                        item.lessonState = lesson.lessonState
                        item.assignmentState = lesson.assignmentState
                        return
                    }
                }
                //append
                student.lessons.append(lesson)
            }
        }
    }
}



