//
//  Weekday.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/03.
//

import Foundation

enum Weekday: Int, CaseIterable {
    
    case monday = 1
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday 

    
    var title: String{
        switch self {
        case .monday:
            return "월"
        case .tuesday:
            return "화"
        case .wednesday:
            return "수"
        case .thursday:
            return "목"
        case .friday:
            return "금"
        case .saturday:
            return "토"
        case .sunday:
            return "일"
        }
    }
}
