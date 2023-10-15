//
//  MessageViewModel.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/15.
//

import Foundation

class MessageViewModel {
    var personType: PersonType = .student
    var student: Student?
    var selectedList: [Date] = []
    var showAssignment: Observable<Bool> = Observable(false)
}
