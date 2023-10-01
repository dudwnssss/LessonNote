//
//  BaseViewController.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/01.
//

import UIKit
import SnapKit
import Then

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.white
        setProperties()
        setLayouts()
        bind()
    }
    
    func setProperties(){}
    func setLayouts(){}
    func bind(){}
}
