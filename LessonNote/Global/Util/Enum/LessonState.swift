//
//  LessonState.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/11.
//

import Foundation

enum LessonState: Int, CaseIterable {
    case completed
    case supplemented
    case canceled
    case none
}

enum AssignmentState: Int, CaseIterable {
    case good
    case soso
    case bad
}
