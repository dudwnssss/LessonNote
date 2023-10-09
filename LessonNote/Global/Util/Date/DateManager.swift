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
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
    
    func formatDatesToENd(dates: [Date]) -> [String] {
        dateFormatter.dateFormat = "E\nd"
        
        let formattedDates = dates.map { date in
            return dateFormatter.string(from: date)
        }
        
        return formattedDates
    }
    
    func getDatesStartingFromMonday() -> [String] {
        var dates: [String] = []
        let calendar = Calendar.current
        let currentDate = Date()
        
        let currentWeekday = calendar.component(.weekday, from: currentDate)
        
        let daysToSubtract = currentWeekday - 2 // 월요일은 2
        let startDate = calendar.date(byAdding: .day, value: -daysToSubtract, to: currentDate)!
        
        for i in 0..<7 {
            if let date = calendar.date(byAdding: .day, value: i, to: startDate) {
                dateFormatter.dateFormat = "E\nd"
                let dateString = dateFormatter.string(from: date)
                dates.append(dateString)
            }
        }
        return dates
    }
    

    func getThisWeekDateString() -> String {
        let calendar = Calendar.current
        let currentDate = Date()
        
        // 현재 날짜의 요일을 가져옵니다.
        let currentWeekday = calendar.component(.weekday, from: currentDate)
        
        // 현재 날짜가 어떤 요일인지에 따라서 이번주의 시작일을 계산합니다.
        // 주의: 일요일부터 시작하는 캘린더의 경우에는 요일 순서를 조정해야 할 수도 있습니다.
        let daysToSubtract = currentWeekday - 2 // 월요일은 2
        let startDate = calendar.date(byAdding: .day, value: -daysToSubtract, to: currentDate)!
        
        // 이번주의 월요일과 일요일 날짜를 가져옵니다.
        let formatter = DateFormatter()
        formatter.dateFormat = "M월 d일"
        
        let monday = formatter.string(from: startDate)
        let sunday = formatter.string(from: calendar.date(byAdding: .day, value: 6, to: startDate)!)
        
        return "\(monday) - \(sunday)"
    }
    
    func getDatesForWeek(numberOfWeeksFromThisWeek: Int) -> [Date] {
        let calendar = Calendar.current
        let currentDate = Date()
        
        let currentWeekday = calendar.component(.weekday, from: currentDate)
        
        let daysToSubtract = currentWeekday - 2 // 월요일은 2
        let startDate = calendar.date(byAdding: .day, value: -daysToSubtract, to: currentDate)!
        
        let startDateOfNthWeek = calendar.date(byAdding: .weekOfYear, value: numberOfWeeksFromThisWeek, to: startDate)!
        let endDateOfNthWeek = calendar.date(byAdding: .day, value: 6, to: startDateOfNthWeek)!
        
        var datesForWeek: [Date] = []
        var currentDateInWeek = startDateOfNthWeek
        while currentDateInWeek <= endDateOfNthWeek {
            datesForWeek.append(currentDateInWeek)
            currentDateInWeek = calendar.date(byAdding: .day, value: 1, to: currentDateInWeek)!
        }
        
        return datesForWeek
    }
    
    func formatCurrentDate() -> String {
        dateFormatter.dateFormat = "E\nd"
        let currentDate = Date()
        let formattedDate = dateFormatter.string(from: currentDate)
        return formattedDate
    }
}
