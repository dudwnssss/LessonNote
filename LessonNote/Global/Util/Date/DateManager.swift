//
//  DateManager.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/07.
//

import Foundation

class DateManager{
    
    static let shared = DateManager()
    private init() {}
    
    let dateFormatter = DateFormatter().then{
        $0.locale = Locale(identifier: "ko_KR")
    }
    
    func formatFullDateToString(date: Date) -> String {
        dateFormatter.dateFormat = "yyyy년 M월 d일 (E)"
        return dateFormatter.string(from: date)
    }
    
}
