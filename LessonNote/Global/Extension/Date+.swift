//
//  Date+.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/04.
//

import Foundation

extension Date {
    
    static func buildTimeRangeString(startDate: Date, endDate: Date) -> String {
        
        let startTimeFormatter = DateFormatter()
        startTimeFormatter.dateFormat = "hh:mm"
        
        let endTimeFormatter = DateFormatter()
        endTimeFormatter.dateFormat = "hh:mm"
        
        return String(format: "%@ - %@",
                      startTimeFormatter.string(from: startDate),
                      endTimeFormatter.string(from: endDate))
        
    }
}
