//
//  UIPickerView+.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/04.
//

import UIKit

extension UIPickerView{
        func setPickerLabelsWith(labels: [String]) {
            let columCount = labels.count
            let fontSize: CGFloat = Font.medium14.pointSize

            var labelList: [UILabel] = []
            for index in 0..<columCount {
                let label = UILabel()
                label.text = labels[index]
                label.font = Font.medium14
                label.textColor = Color.gray6
                label.sizeToFit()
                labelList.append(label)
            }

            let pickerWidth: CGFloat = self.frame.width
            let labelY: CGFloat = (self.frame.size.height / 2) - (fontSize / 2)

            for (index, label) in labelList.enumerated() {
                let labelX: CGFloat = (pickerWidth / CGFloat(columCount)) * CGFloat(index + 1)
                label.frame = CGRect(x: labelX, y: labelY, width: fontSize, height: fontSize)
                self.addSubview(label)
            }
        }
}
