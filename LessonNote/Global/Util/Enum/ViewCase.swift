//
//  ViewCase.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/05.
//

import UIKit

enum ViewCase {
    case studentName(String, Int)
    case studentIcon
    case studentPhoneNumber
    case parentPhoneNumber
    case weekday
    case lessonTime
    case weekCount
    case lessonStartDate
    
    var view: UIView{
        switch self{
        case .studentName(let placeholder, let limitCount):
            return CustomTextFieldView(placeholder: placeholder, limitCount: limitCount)
        case .studentIcon:
            return StudentIconStackView()
        case .studentPhoneNumber:
            return UIView()
        case .parentPhoneNumber:
            return UIView()
        case .weekday:
            return WeekdayStackView()
        case .lessonTime:
            return LessonTimePickerTextField()
        case .weekCount:
            return WeekCountView()
        case .lessonStartDate:
            return UIView()
        }
    }
}
