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
    
    func fetch() -> RealmSwift.Results<Student> {
        let data = realm.objects(Student.self).sorted(byKeyPath: "studentName", ascending: false)
        return data
    }
    
    func create(_ item: Student) {
        do {
            try! realm.write{
                realm.add(item)
            }
        }
    }
    
    func delete(_ item: Student) {
        do {
            try! realm.write{
                realm.delete(item)
            }
        }
    }
}
