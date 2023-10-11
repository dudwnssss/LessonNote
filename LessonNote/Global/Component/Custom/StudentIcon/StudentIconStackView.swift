//
//  StudentIconStackView.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/02.
//

import UIKit

final class StudentIconStackView: UIStackView{
    
//    var selectedIcon : StudentIcon = .pink
    
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
    
    private let horizontalStackView1 = UIStackView()
    private let horizontalStackView2 = UIStackView()
    
    
    private func setProperties(){
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
        
        axis = .vertical
        spacing = 8
        distribution = .fillEqually

    }
    
    private func setLayouts(){
        addSubviews(horizontalStackView1, horizontalStackView2)
        for (index, button) in studentIconButtonList.enumerated() {
                (index < studentIconButtonList.count / 2 ? horizontalStackView1 : horizontalStackView2).addArrangedSubview(button)
            }
        addArrangedSubviews(horizontalStackView1, horizontalStackView2)
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
