//
//  LessonTime.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/05.
//

import Foundation

struct LessonTime {
    let weekday: Weekday
    let startTime: Date
    let endTime: Date
}

extension LessonTime {
    func toLessonSchedule() -> LessonSchedule {
        let lessonSchedule = LessonSchedule()
        lessonSchedule.weekday = self.weekday.rawValue
        lessonSchedule.startTime = self.startTime
        lessonSchedule.endTime = self.endTime
        return lessonSchedule
    }
}
