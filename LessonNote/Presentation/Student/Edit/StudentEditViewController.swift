//
//  StudentEditViewController.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/17.
//

import UIKit

final class StudentEditViewController: BaseViewController {
    
    private let studentEditView = StudentEditView()
    let viewModel = StudentEditViewModel()
    
    override func loadView() {
        self.view = studentEditView
    }
    
    override func setNavigationBar() {
        navigationItem.title = "학생 편집"
    }
}
