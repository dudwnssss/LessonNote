//
//  LessonBottomSheetViewController.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/13.
//

import UIKit

final class LessonBottomSheetViewController: BaseViewController {
    
    private let lessonBottomSheetView = LessonBottomSheetView()
    let lessonBottomSheetViewModel = LessonBottomSheetViewModel()
    
    override func loadView() {
        self.view = lessonBottomSheetView
    }
}
