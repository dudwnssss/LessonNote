//
//  StudentView.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/10.
//

import UIKit

class StudentView: BaseView {
    let scrollView = UIScrollView()
    let contentView = UIView()
    let customStudentView = CustomStudentView()
    let calendarView = CalendarView()
    
    
    override func setProperties() {
        calendarView.appearance.do {
            $0.selectionColor = .clear
            $0.eventDefaultColor = .clear
        }
    }
    override func setLayouts() {
        addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
        
        scrollView.addSubview(contentView)
        
        contentView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.centerX.top.bottom.equalToSuperview()
        }
        
        contentView.addSubviews(customStudentView, calendarView)
        customStudentView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
             $0.top.equalToSuperview().offset(18)
        }
        calendarView.snp.makeConstraints {
            $0.top.equalTo(customStudentView.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(calendarView.snp.width)
            $0.bottom.equalToSuperview().offset(-60)
        }
    }
    
    func configureStudentView(student: Student){
        guard let studentIcon = StudentIcon(rawValue: student.studentIcon) else {return}
        customStudentView.configureView(student: student)
    }
}

@available(iOS 17.0, *)
#Preview {
    StudentView()
}

