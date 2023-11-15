//
//  LessonMessage.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/16.
//

import Foundation

struct LessonMessage {
    let title: String?
    let dates: [Date]
    let comment: String?
    let assignment: Bool
    let personType: PersonType
}
