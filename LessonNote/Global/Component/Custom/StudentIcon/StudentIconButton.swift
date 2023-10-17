//
//  StudentIconButton.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/02.
//

import UIKit

final class StudentIconButton: UIButton {
    
    var studentIcon : StudentIcon?
    //    var isTapped = false {
    //        didSet {
    //            configureButton()
    //        }
    //    }
    //
    init(studentIcon: StudentIcon){
        self.studentIcon = studentIcon
        super.init(frame: .zero)
        setProperties()
        setLayouts()
    }
    
    private func setProperties(){
        setImage(studentIcon?.image, for: .normal)
    }
    
    private func setLayouts(){
        snp.makeConstraints {
            $0.size.equalTo(65)
        }
    }
    
    func configureButton(isSelected: Bool){
        switch isSelected{
        case true:
            UIView.transition(with: self, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.setImage(self.studentIcon?.selectedImage, for: .normal)
                self.borderWidth = 2
                self.borderColor = .black
            }) { _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    UIView.transition(with: self, duration: 0.15, options: .transitionCrossDissolve, animations: {
                        self.setImage(self.studentIcon?.image, for: .normal)
                    }) { _ in
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                            UIView.transition(with: self, duration: 0.2, options: .transitionCrossDissolve, animations: {
                                self.setImage(self.studentIcon?.selectedImage, for: .normal)
                            }, completion: nil)
                        }
                    }
                }
            }
        case false:
            setImage(studentIcon?.image, for: .normal)
            borderWidth = 0
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cornerRadius = frame.width / 2
    }
    
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
