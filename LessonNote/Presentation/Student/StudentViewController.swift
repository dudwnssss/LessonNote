//
//  StudentViewController.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/10.
//

import UIKit

final class StudentViewController: BaseViewController {
    
    var student: Student?
    
    let studentView = StudentView()
    override func loadView() {
        self.view = studentView
    }
    
    override func setProperties() {
        view.backgroundColor = Color.gray1
        if let student {
            studentView.customStudentView.configureView(student: student)
        }
    }
}
