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
    
    func generateClassDates(startDate: Date, classDays: [Weekday], interval: Int) -> [Date] {
        var classDates: [Date] = []
        
        // 시작일의 요일을 확인하여 수업 요일 중 가장 빠른 요일로 조정합니다.
        let calendar = Calendar.current
        let startWeekday = calendar.component(.weekday, from: startDate)
        let earliestClassDay = classDays.min(by: { $0.rawValue < $1.rawValue }) ?? .monday
        let daysUntilEarliestClassDay = (earliestClassDay.rawValue - startWeekday + 7) % 7
        let adjustedStartDate = calendar.date(byAdding: .day, value: daysUntilEarliestClassDay, to: startDate)!
        
        // 수업 일자를 계산합니다.
        var currentDate = adjustedStartDate
        let endDate = calendar.date(byAdding: .year, value: 1, to: adjustedStartDate)!
        
        while currentDate <= endDate {
            if let currentWeekday = Weekday(rawValue: calendar.component(.weekday, from: currentDate)),
               classDays.contains(currentWeekday) {
                classDates.append(currentDate)
            }
            currentDate = calendar.date(byAdding: .day, value: interval * 7, to: currentDate)!
        }
        
        return classDates
    }

}
