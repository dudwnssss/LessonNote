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
    
    func formatTime(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
    
    func getDatesStartingFromMonday() -> [String] {
        var dates: [String] = []
        let calendar = Calendar.current
        let currentDate = Date()
        
        // 현재 요일을 가져옵니다 (1: 일요일, 2: 월요일, ..., 7: 토요일)
        let currentWeekday = calendar.component(.weekday, from: currentDate)
        
        // 현재 날짜가 일요일인 경우에는 이번 주 월요일을 계산합니다.
        var startDate: Date
        if currentWeekday == 1 {
            startDate = calendar.date(byAdding: .day, value: -6, to: currentDate)!
        } else {
            // 다음 주의 월요일을 계산합니다.
            let daysUntilMonday = (8 - currentWeekday) % 7
            startDate = calendar.date(byAdding: .day, value: daysUntilMonday, to: currentDate)!
        }
        
        // 월요일부터 일요일까지의 날짜를 배열에 추가합니다.
        for i in 0..<7 {
            if let date = calendar.date(byAdding: .day, value: i, to: startDate) {
                // "월\n24" 형태의 문자열로 포맷팅합니다.
                dateFormatter.dateFormat = "E\nd"
                let dateString = dateFormatter.string(from: date)
                dates.append(dateString)
            }
        }
        return dates
    }
}
