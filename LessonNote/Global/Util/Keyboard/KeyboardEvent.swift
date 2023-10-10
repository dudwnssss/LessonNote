//
//  KeyboardEvent.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/06.
//
import UIKit

protocol KeyboardEvent where Self: UIViewController {
    var transformView: UIView { get }
    func setupKeyboardEvent()
}

extension KeyboardEvent where Self: UIViewController {
    func setupKeyboardEvent() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification,
                                               object: nil,
                                               queue: OperationQueue.main) { [weak self] notification in
            self?.keyboardWillAppear(notification)
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification,
                                               object: nil,
                                               queue: OperationQueue.main) { [weak self] notification in
            self?.keyboardWillDisappear(notification)
        }
    }
    
    func removeKeyboardObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func keyboardWillAppear(_ sender: Notification) {
        guard let keyboardFrame = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextField = UIResponder.currentResponder as? UITextField else { return }
        
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextFieldFrame = transformView.convert(currentTextField.frame, from: currentTextField.superview)
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height
        
        if textFieldBottomY > keyboardTopY {
            // 이미 키보드가 올라간 높이만큼 빼고 다시 계산하여 화면을 올립니다.
            let newFrame = textFieldBottomY - keyboardTopY + 10 // 여기서 10은 여백을 조절할 수 있는 값
            transformView.frame.origin.y -= newFrame
        }
    }
    
    private func keyboardWillDisappear(_ sender: Notification) {
        if transformView.frame.origin.y != 0 {
            transformView.frame.origin.y = 0
        }
    }
}
