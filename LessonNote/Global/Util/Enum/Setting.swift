//
//  Setting.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/23.
//

import UIKit

enum Setting: Int, CaseIterable{
    case privacy
    case inquiry
    
    var settingTitle: String {
        switch self {
        case .privacy:
            return "개인정보 처리방침"
        case .inquiry:
            return "문의 및 피드백"
        }
    }
    
    var settingImage: UIImage {
        switch self {
        case .privacy:
            return Image.privacy
        case .inquiry:
            return Image.inquiry
        }
    }
    
    var path: String {
        switch self {
        case .privacy:
            return "https://atom-technician-7aa.notion.site/LessonNote-6bdb51a4f7a74fa4a44c478cc50b21b7?pvs=4"
        case .inquiry:
            return "https://instagram.com/lessonnote.official?igshid=OGQ5ZDc2ODk2ZA%3D%3D&utm_source=qr"
        }
    }
}
