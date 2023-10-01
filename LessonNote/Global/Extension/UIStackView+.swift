//
//  UIStackView+.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/01.
//

import UIKit.UIStackView

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        for view in views {
            addArrangedSubview(view)
        }
    }
}
