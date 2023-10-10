//
//  HomeViewModel.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/02.
//

import Foundation
import RealmSwift

final class HomeViewModel{
    
    private let repository = StudentRepository()
    private var studentResults: Results<Student>! // realm기반, 변경 시 list에 값 전달
    private var notificationToken: NotificationToken?
    
    lazy var studentList: Observable<[Student]> = Observable([])
    
    init(){
        studentResults = repository.fetch()
        studentList.value = Array(studentResults)
        notificationToken = studentResults.observe { [weak self] (changes: RealmCollectionChange) in
            switch changes {
            case .initial:
                break
            case .update(let collectionType, let deletions, let insertions, let modifications):
                self?.studentList.value = Array((self?.studentResults)!)
                break
            case .error(let error):
                print(error)
                break
            }
        }
        observeLessonSchedules()
    }
    
    private func observeLessonSchedules() {
        for student in studentResults {
            for lessonSchedule in student.lessonSchedules {
                lessonSchedule.observe { [weak self] (change: ObjectChange) in
                    switch change {
                    case .change, .deleted:
                        self?.studentList.value = Array((self?.studentResults)!)
                    case .error(let error):
                        print(error)
                    }
                }
            }
        }
    }

    
    deinit {
           notificationToken?.invalidate()
       }
}
