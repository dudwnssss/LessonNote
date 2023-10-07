//
//  StudentIconStackView.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/02.
//

import UIKit

class StudentIconStackView: UIStackView{
    
    var selectedIcon : StudentIcon = .pink
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setProperties()
        setLayouts()
    }
    
    let studentIconButtonList = [StudentIconButton(studentIcon: .pink),
                                 StudentIconButton(studentIcon: .orange),
                                 StudentIconButton(studentIcon: .yellow),
                                 StudentIconButton(studentIcon: .green),
                                 StudentIconButton(studentIcon: .skyblue),
                                 StudentIconButton(studentIcon: .blue),
                                 StudentIconButton(studentIcon: .violet),
                                 StudentIconButton(studentIcon: .magenta)]
    
    let horizontalStackView1 = UIStackView()
    let horizontalStackView2 = UIStackView()
    
    
    func setProperties(){
        horizontalStackView1.do {
            $0.distribution = .fillEqually
            $0.axis = .horizontal
            $0.spacing = 8
        }
        horizontalStackView2.do {
            $0.distribution = .fillEqually
            $0.axis = .horizontal
            $0.spacing = 8
        }
        studentIconButtonList.forEach {
            $0.addTarget(self, action: #selector(buttonDidTap(sender:)), for: .touchUpInside)
        }
        studentIconButtonList.first?.isTapped = true
        
        axis = .vertical
        spacing = 8
        distribution = .fillEqually

    }
    
    func setLayouts(){
        addSubviews(horizontalStackView1, horizontalStackView2)
        for (index, button) in studentIconButtonList.enumerated() {
                (index < studentIconButtonList.count / 2 ? horizontalStackView1 : horizontalStackView2).addArrangedSubview(button)
            }
        addArrangedSubviews(horizontalStackView1, horizontalStackView2)
    }
    
    @objc func buttonDidTap(sender: StudentIconButton){
        for item in studentIconButtonList{
            item.isTapped = false
        }
        sender.isTapped = true
        guard let icon = sender.studentIcon else {return}
        selectedIcon = icon
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
