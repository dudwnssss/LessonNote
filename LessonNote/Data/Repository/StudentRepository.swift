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
    
    //수업 추가-갱신 (Upsert)
    func appendLesson(student: Student, lesson: Lesson) {
        do {
            try! realm.write{
                student.lessons.append(lesson)
            }
        }
    }
    
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



