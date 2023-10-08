//
//  StudentRepository.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/03.
//

import Foundation
import RealmSwift

class StudentRepository{
    
    private let realm = try! Realm()
    
    //학생 전체 불러오기
    func fetch() -> RealmSwift.Results<Student> {
        let data = realm.objects(Student.self).sorted(byKeyPath: "studentName", ascending: false)
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
    
    //수업 삭제

    
}



