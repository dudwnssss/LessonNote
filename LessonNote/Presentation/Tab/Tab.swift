//
//  Tab.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/01.
//

import UIKit

enum Tab: Int, CaseIterable{
    case home
    case schedule
    
    var image: UIImage{
        switch self {
        case .home:
            return Image.home
        case .schedule:
            return Image.calendar
        }
    }
    
    var selectedImage: UIImage{
        switch self {
        case .home:
            return Image.homeFill
        case .schedule:
            return Image.calendarFill
        }
    }
}
