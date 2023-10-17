//
//  UIString+.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/17.
//

import Foundation

extension String {
    public var withHypen: String {
      var stringWithHypen: String = self
      
      stringWithHypen.insert("-", at: stringWithHypen.index(stringWithHypen.startIndex, offsetBy: 3))
      stringWithHypen.insert("-", at: stringWithHypen.index(stringWithHypen.endIndex, offsetBy: -4))
      
      return stringWithHypen
    }
}
