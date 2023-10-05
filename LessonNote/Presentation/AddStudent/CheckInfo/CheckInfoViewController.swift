//
//  CheckInfoViewController.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/02.
//

import UIKit

class CheckInfoViewController: BaseViewController{
    
    let checkInfoView = CheckInfoView()
    override func loadView() {
        self.view = checkInfoView
    }
    
    override func setNavigationBar() {
        navigationItem.title = "학생 추가"
    }
    
    override func setProperties() {
        view.backgroundColor = Color.gray1
        checkInfoView.completeButton.addTarget(self, action: #selector(completeButtonDidTap), for: .touchUpInside)
    }
    
    @objc func completeButtonDidTap(){
        navigationController?.popToRootViewController(animated: true)
    }
}
