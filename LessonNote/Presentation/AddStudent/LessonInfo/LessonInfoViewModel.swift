//
//  LessonInfoViewModel.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/05.
//

import Foundation

class LessonInfoViewModel{
    
    var lessonTimeList: [LessonTime] = [LessonTime(weekday: .monday , startTime: Date(), endTime: Date()), LessonTime(weekday: .tuesday, startTime: Date(), endTime: Date())]
    
    
}