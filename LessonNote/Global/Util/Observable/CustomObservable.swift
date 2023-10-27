//
//  Observable.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/05.
//

import Foundation

class CustomObservable<T> {
    
    private var listner: ((T) -> Void )?
    
    var value: T {
        didSet{
            listner?(value)
        }
    }

    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        listner = closure
    }
}
