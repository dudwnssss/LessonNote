//
//  ElliottEvent.swift
//  Elliotable
//
//  Created by TaeinKim on 2019/11/02.
//  Copyright © 2019 TaeinKim. All rights reserved.
//

import Foundation
import UIKit

 struct ElliottEvent {
     let courseId  : String
     let studentName: String
     let roomName  : String
     let courseDay : ElliotDay
     let startTime : String
     let endTime   : String
     let textColor      : UIColor?
     let backgroundColor: UIColor
     let student: Student
    
     init(courseId: String, courseName: String, roomName: String, courseDay: ElliotDay,startTime: String, endTime: String, textColor: UIColor? = .white, backgroundColor: UIColor, student: Student) {
        self.courseId        = courseId
        self.studentName      = courseName
        self.roomName        = roomName
        self.courseDay       = courseDay
        self.startTime       = startTime
        self.endTime         = endTime
        self.textColor       = textColor
        self.backgroundColor = backgroundColor
        self.student = student
    }
    
}
