//
//  CGFloat+.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/02.
//

import UIKit

extension CGFloat { // Double도 동일
  var adjusted: CGFloat {
      let ratio: CGFloat = UIScreen.main.bounds.width / 375
      return self * ratio
  }
}

extension Double{
    var adjusted: Double {
        let ratio: Double = UIScreen.main.bounds.width / 375.0
        return self * ratio
    }
}


