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

    func getDateRange(numberOfWeeksFromThisWeek: Int) -> String {
        let calendar = Calendar.current
        let currentDate = Date()
        
        let currentWeekday = calendar.component(.weekday, from: currentDate)
        
        let daysToSubtract = currentWeekday - 2 // 월요일은 2
        let startDate = calendar.date(byAdding: .day, value: -daysToSubtract, to: currentDate)!
        
        let startDateOfNthWeek = calendar.date(byAdding: .weekOfYear, value: numberOfWeeksFromThisWeek, to: startDate)!
        let endDateOfNthWeek = calendar.date(byAdding: .day, value: 6, to: startDateOfNthWeek)!
        
        let formatter = DateFormatter()
        formatter.dateFormat = "M월 d일"
        
        let monday = formatter.string(from: startDateOfNthWeek)
        let sunday = formatter.string(from: endDateOfNthWeek)
        
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
    

    func getSundayDate(forWeekOffset offset: Int) -> Date? {
        var calendar = Calendar.current
        calendar.locale = Locale.current

        calendar.firstWeekday = 2

        let currentDate = Date()

        if let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: currentDate)),
            let sundayDate = calendar.date(byAdding: .weekOfYear, value: offset, to: startOfWeek),
            let nextSunday = calendar.date(byAdding: .day, value: 6, to: sundayDate) {
            return nextSunday
        }

        return nil
    }
    
    
     func buildTimeRangeString(startDate: Date, endDate: Date) -> String {
        
        dateFormatter.dateFormat = "hh:mm"
        
        return String(format: "%@ - %@",
                      dateFormatter.string(from: startDate),
                      dateFormatter.string(from: endDate))
        
    }
    
    func weekdayFromDate(_ date: Date) -> Weekday? {
        let calendar = Calendar.current
        let weekdayNumber = calendar.component(.weekday, from: date)

        switch weekdayNumber {
        case 1:
            return .sunday
        case 2:
            return .monday
        case 3:
            return .tuesday
        case 4:
            return .wednesday
        case 5:
            return .thursday
        case 6:
            return .friday
        case 7:
            return .saturday
        default:
            return nil
        }
    }
    
    func generateYearlyLessonSchedule(weekday: [Weekday.RawValue], weekCount: Int, startWeekday: Weekday.RawValue, startDate: Date) -> [Date] {
        var lessonDates: [Date] = []
        
        // Calendar 객체를 생성합니다.
        let calendar = Calendar.current
        
        // 현재 날짜를 가져옵니다.
        var currentDate = startDate
        
        for _ in 1...52 { // 1년치(52주)를 계산합니다.
            for day in weekday {
                // 현재 요일을 기준으로 수업 시작 날짜를 찾습니다.
                let weekdayDifference = (day - startWeekday + 7) % 7
                let nextLessonDate = calendar.date(byAdding: .day, value: weekdayDifference, to: currentDate)!
                
                // 수업 날짜를 추가합니다.
                lessonDates.append(nextLessonDate)
            }
            
            // 주차를 늘립니다.
            currentDate = calendar.date(byAdding: .weekOfYear, value: weekCount, to: currentDate)!
        }
        
        return lessonDates
    }
    
    func countUniqueMonths(dates: [Date]) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-yyyy"
        var uniqueMonths = Set<String>()
        for date in dates {
            let monthYear = dateFormatter.string(from: date)
            uniqueMonths.insert(monthYear)
        }
        return uniqueMonths.count
    }
}
