//
//  PersonType.swift
//  LessonNote
//
//  Created by 임영준 on 2023/11/17.
//

import Foundation

enum PersonType {
    case student
    case parent
    
    var title: String {
        switch self {
        case .student:
            return "학생"
        case .parent:
            return "학부모"
        }
    }
}
