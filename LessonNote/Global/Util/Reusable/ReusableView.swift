//
//  ReusableView.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/01.
//

import UIKit.UIView

protocol ReusableView: AnyObject {}

extension ReusableView where Self: UIView{
    static var reuseIdentifier: String {
        return self.description()
    }
}

