//
//  HomeViewController.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/01.
//

import UIKit

class HomeViewController: BaseViewController{
    
    
    override func setNavigationBar() {
        navigationItem.title = "홈"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.gray1
    }
}
