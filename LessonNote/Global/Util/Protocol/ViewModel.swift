//
//  ViewModel.swift
//  LessonNote
//
//  Created by 임영준 on 2023/11/12.
//

import Foundation
import RxSwift
import RxCocoa

protocol ViewModel {
    
    associatedtype Input
    associatedtype Output
    func transform(input: Input, disposeBag: DisposeBag) -> Output
    
}
