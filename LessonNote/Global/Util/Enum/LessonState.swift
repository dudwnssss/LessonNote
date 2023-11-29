//
//  LessonState.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/11.
//

import UIKit

enum LessonState: Int, CaseIterable {
    case completed
    case canceled
    case supplemented
    case none
    
    var title: String {
        switch self {
        case .completed:
            return "정상 수업"
        case .canceled:
            return "휴강"
        case .supplemented:
            return "보강"
        case .none:
            return "수업 없음"
        }
    }
    
    var calendarTitle: String? {
        switch self {
        case .completed:
            return "완료"
        case .canceled:
            return "휴강"
        case .supplemented:
            return "보강"
        case .none:
            return nil
        }
    }
}
//state
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
    
    var image: UIImage {
        switch self {
        case .good:
            return Image.assignmentGood
        case .soso:
            return Image.assignmentSoso
        case .bad:
            return Image.assignmentBad
        }
    }
}
