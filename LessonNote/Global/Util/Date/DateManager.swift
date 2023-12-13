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
    
    func formatTimeMinute(from date: Date) -> String {
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
    
    func formatDatesToEnd(dates: [Date]) -> [String] {
        dateFormatter.dateFormat = "E\nd"
        
        let formattedDates = dates.map { date in
            return dateFormatter.string(from: date)
        }
        
        return formattedDates
    }
    
    func getYearAgoDate() -> Date {
        let calendar = Calendar.current
        let dateYearAgo = calendar.date(byAdding: .year, value: -1, to: Date())
        return dateYearAgo ?? Date()
    }
    
    func getYearLaterDate() -> Date {
        let calendar = Calendar.current
        let date = calendar.date(byAdding: .year, value: 1, to: Date())
        return date ?? Date()
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
        let currentWeekday = calendar.component(.weekday, from: Date())
        let daysToSubtract: Int
        
        if currentWeekday == 1 { // 일요일
            daysToSubtract = 6
        } else {
            daysToSubtract = currentWeekday - 2
        }
        
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
    
    func formatCurrentWeekday() -> String {
        dateFormatter.dateFormat = "E\nd"
        let currentDate = Date()
        let formattedDate = dateFormatter.string(from: currentDate)
        return formattedDate
    }
    
     func buildTimeRangeString(startDate: Date, endDate: Date) -> String {
        
        dateFormatter.dateFormat = "HH:mm"
        return String(format: "%@ - %@",
                      dateFormatter.string(from: startDate),
                      dateFormatter.string(from: endDate))
        
    }
    
    func generateYearlyLessonSchedule(weekday: [Weekday.RawValue], weekCount: Int, startWeekday: Weekday.RawValue, startDate: Date) -> [Date] {
        var lessonDates: [Date] = []
        let calendar = Calendar.current
        
        var currentDate = startDate
       
        //월1, 화2, 수3, 목4, 금5, 토6, 일7
        var newWeekday: [Int] = []
        weekday.forEach { value in
            if value < startWeekday {
                newWeekday.append(value + 7)
            } else {
                newWeekday.append(value)
            }
        }
        newWeekday.sort() //3 5 6 8
        var firstWeek: [Date] = []
        
        for day in newWeekday {
            let difference = day - weekdayNumber(from: startDate)
            let nextLessonDate = calendar.date(byAdding: .day, value: difference, to: currentDate)!
            firstWeek.append(nextLessonDate)
        }
        
        //startDate를 요일로 변환한것의 ravalue와 차이를 기반으로 1주치 날짜 계산
        //1주치날짜를 기준으로 격주주차*7을 더하면서 1년치 날짜 계산
        return generateYearlyDates(from: firstWeek, withInterval: weekCount)
    }
    
    
    func generateYearlyDates(from dates: [Date], withInterval interval: Int) -> [Date] {
        var yearlyDates: [Date] = []
        
        let calendar = Calendar.current
        let oneYearInSeconds: TimeInterval = 31536000 * 3 

        for date in dates {
            var currentDate = date

            for _ in 1...52 * 3 {

                yearlyDates.append(currentDate)

                // 현재 날짜에 interval 주기만큼 더합니다
                if let nextDate = calendar.date(byAdding: .day, value: 7 * interval, to: currentDate) {
                    currentDate = nextDate
                }

                // 1년을 더한 시점에서 반복을 멈춥니다
                if currentDate.timeIntervalSince(date) >= oneYearInSeconds {
                    break
                }
            }
        }

        return yearlyDates
    }

    
    
    func weekdayNumber(from date: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.weekday], from: date)
        
        if var weekday = components.weekday {
            // 요일 숫자를 월요일부터 1부터 7까지로 변경
            weekday -= 1
            if weekday == 0 {
                weekday = 7
            }
            return weekday
        } else {
            return 0  // 요일을 찾을 수 없을 때 0을 반환
        }
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
    
    func areDatesEqualIgnoringTime(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current
        let components1 = calendar.dateComponents([.year, .month, .day], from: date1)
        let components2 = calendar.dateComponents([.year, .month, .day], from: date2)
        return components1 == components2
    }
    
    func isDate(_ date: Date, before startDate: Date) -> Bool {
        let calendar = Calendar.current
        let normalizedStartDate = calendar.startOfDay(for: startDate)
        let normalizedDate = calendar.startOfDay(for: date)
        return normalizedDate < normalizedStartDate
    }

        
    func generateWeeksArray(from dates: [Date], numberOfWeeks: Int) -> [[Bool]] {
        var calendar = Calendar(identifier: .iso8601)
        calendar.firstWeekday = 2 // 월요일을 첫 번째 요일로 설정
        var weeksArray: [[Bool]] = []

        // 오늘이 포함된 이번 주의 시작 날짜 계산
        let currentDate = Date()
        var startDate = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: currentDate))!
        var currentIndex = 0

        while currentIndex < numberOfWeeks {
            var weekArray = Array(repeating: false, count: 7)

            for i in 0..<7 {
                let day = calendar.date(byAdding: .day, value: i, to: startDate)!
                if dates.contains(where: { calendar.isDate($0, inSameDayAs: day) }) {
                    weekArray[i] = true
                }
            }

            weeksArray.append(weekArray)

            // 다음 주로 이동
            startDate = calendar.date(byAdding: .weekOfYear, value: 1, to: startDate)!
            currentIndex += 1
        }

        return weeksArray
    }
    
    
    func hundredYearFromToday() -> Date {
        let currentDate = Date()
        let calendar = Calendar.current
        
        var dateComponents = DateComponents()
        dateComponents.year = 100
        
        let oneYearFromNow = calendar.date(byAdding: dateComponents, to: currentDate)
        
        return oneYearFromNow!
    }

}
