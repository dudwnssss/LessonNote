//
//  StudentIcon.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/02.
//

import UIKit

enum StudentIcon: Int{
    case pink
    case orange
    case yellow
    case green
    case skyblue
    case blue
    case violet
    case magenta
    
    var color: UIColor{
        switch self {
        case .pink:
            return Color.Icon.pink
        case .orange:
            return Color.Icon.orange
        case .yellow:
            return Color.Icon.yellow
        case .green:
            return Color.Icon.green
        case .skyblue:
            return Color.Icon.skyblue
        case .blue:
            return Color.Icon.blue
        case .violet:
            return Color.Icon.violet
        case .magenta:
            return Color.Icon.magenta
        }
    }
    var image: UIImage{
        switch self {
        case .pink:
            return Image.Icon.studentPink
        case .orange:
            return Image.Icon.studentOrange
        case .yellow:
            return Image.Icon.studentYellow
        case .green:
            return Image.Icon.studentGreen
        case .skyblue:
            return Image.Icon.studentSkyblue
        case .blue:
            return Image.Icon.studentBlue
        case .violet:
            return Image.Icon.studentViolet
        case .magenta:
            return Image.Icon.studentMagenta
        }
    }
}
