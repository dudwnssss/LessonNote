//
//  LessonViewController.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/11.
//

import UIKit

final class LessonViewController: BaseViewController {    
    
    private let lessonView = LessonView()
    let lessonViewModel = LessonViewModel()
    
    override func loadView() {
        self.view = lessonView
    }
    
    override func setProperties() {
        hideKeyboardWhenTappedAround()
        lessonView.LessonButtons.forEach {
            $0.addTarget(self, action: #selector(lessonButtonDidTap(sender:)), for: .touchUpInside)
        }
        lessonView.AssignmentButtons.forEach {
            $0.addTarget(self, action: #selector(AssignmentButtonDidTap(sender:)), for: .touchUpInside)
        }
        lessonView.completeButton.do {
            $0.addTarget(self, action: #selector(compeleteButtonDidTap), for: .touchUpInside)
            $0.isActivated = true
        }
    }
    
    @objc
    func normalButtonDidTap(sender: CustomButton) {
        toggleButton()
        lessonViewModel.selectedLessonState.value = .completed
    }
    
    @objc func lessonButtonDidTap(sender: CustomButton){
        lessonView.LessonButtons.forEach {
            $0.isActivated = false
        }
        sender.isActivated = true
    }
    @objc func AssignmentButtonDidTap(sender: CustomButton){
        lessonView.AssignmentButtons.forEach {
            $0.isActivated = false
        }
        sender.isActivated = true
    }
    
    @objc func compeleteButtonDidTap(){
        navigationController?.popViewController(animated: true)
//        lessonViewModel.appendLesson()
    }
    
    private func toggleButton() {
        lessonView.AssignmentButtons.forEach {
            $0.isActivated = false
        }
    }
    
    func setSelectedLesson(){
        for i in 0 ..< lessonView.LessonButtons.count{
            if lessonView.LessonButtons[i].isActivated == true {
                lessonViewModel.selectedLessonState.value = LessonState(rawValue: i)
                break
            }
        }
    }
    func setSelectedAssignment(){
        for i in 0 ..< lessonView.AssignmentButtons.count{
            if lessonView.AssignmentButtons[i].isActivated == true {
                lessonViewModel.selectedAssignmentState.value = AssignmentState(rawValue: i)
                break
            }
        }
    }
}
