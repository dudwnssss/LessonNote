//
//  CheckInfoView.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/02.
//

import UIKit

final class CheckInfoView: BaseView {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .light))

    let titleLabel = UILabel()
    let customInfoView = CustomCheckInfoView()
    let completeButton = CompleteButton(title: "학생 추가 완료")
    
    override func setProperties() {
        titleLabel.do {
            let fullString = "입력한 정보를\n확인해주세요"
            let attrString = NSMutableAttributedString(string: fullString)
            let range = (fullString as NSString).range(of: "입력한 정보")
            attrString.addAttribute(.font, value: Font.bold20, range: range)
            $0.font = Font.medium20
            $0.numberOfLines = 0
            $0.attributedText = attrString
        }
        completeButton.do {
            $0.configureButton(isValid: true)
        }

    }
    
    override func setLayouts() {
        
        addSubviews(scrollView, blurView, completeButton)

        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        scrollView.addSubview(contentView)
        
        contentView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.centerX.top.bottom.equalToSuperview()
        }
        
        contentView.addSubviews(titleLabel, customInfoView)
                
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(25)
            $0.top.equalToSuperview().offset(20)
        }
        
        customInfoView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalTo(titleLabel.snp.bottom).offset(36)
            $0.height.greaterThanOrEqualTo(400)
            $0.bottom.equalToSuperview().offset(-140)
        }
        
        blurView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.top.equalTo(completeButton.snp.centerY)
        }

        completeButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().offset(-48)
        }
    }
}
