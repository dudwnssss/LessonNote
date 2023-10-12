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
    
    var title: String {
        switch self {
        case .completed:
            return "정상 수업"
        case .supplemented:
            return "휴강"
        case .canceled:
            return "보강"
        case .none:
            return "수업 없음"
        }
    }
}

enum AssignmentState: Int, CaseIterable {
    case good
    case soso
    case bad
    
    var title: String {
        switch self {
        case .good:
            return "O 완료"
        case .soso:
            return "△ 미흡"
        case .bad:
            return "X 미수행"
        }
    }
}
