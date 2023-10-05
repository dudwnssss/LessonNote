//
//  StartDateInfoViewController.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/05.
//

import UIKit

class StartDateInfoViewController: BaseViewController{
    
    let startDateInfoView = StartDateInfoView()
    override func loadView() {
        self.view = startDateInfoView
    }
    
    override func setNavigationBar() {
        navigationItem.title = "학생 추가"
    }
    
    override func setProperties() {
        hideKeyboardWhenTappedAround()
        startDateInfoView.nextButton.addTarget(self, action: #selector(nextButtonDidTap), for: .touchUpInside)
    }
    
    @objc func nextButtonDidTap(){
        let vc = CheckInfoViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
