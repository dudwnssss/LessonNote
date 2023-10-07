//
//  HomeViewModel.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/02.
//

import Foundation

class HomeViewModel{
    
    private let repository = StudentRepository()
    lazy var studentResults = repository.fetch()
    lazy var studentList = Array(studentResults)
}
