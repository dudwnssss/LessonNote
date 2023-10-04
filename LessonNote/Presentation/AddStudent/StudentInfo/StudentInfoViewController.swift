//
//  StudentInfoViewController.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/02.
//

import UIKit

class StudentInfoViewController: BaseViewController {
    
    let studentInfoView = StudentInfoView()
    override func loadView() {
        self.view = studentInfoView
    }
    
    override func setNavigationBar() {
        navigationItem.title = "학생 추가"
    }
    
    override func setProperties() {
        hideKeyboardWhenTappedAround()
    }
    

}
