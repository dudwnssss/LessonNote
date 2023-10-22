//
//  TimetableHeader.swift
//  TimeTable
//
//  Created by 임영준 on 2023/09/27.
//

import UIKit

final class TimetableHeader: UIView{
    
    let dateLabel = UILabel()
    let todayButton = UIButton()
    private let backgroundView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setProperties()
        setLayouts()
    }
    
    func setProperties(){
        dateLabel.do {
            $0.font = Font.medium14
            $0.textColor = Color.gray5
        }
        todayButton.do {
            $0.backgroundColor = Color.black
            $0.layer.cornerRadius = 5
            $0.setTitle("오늘", for: .normal)
            $0.titleLabel?.font = Font.medium12
            $0.setTitleColor(.white, for: .normal)
        }
        backgroundView.do {
            $0.backgroundColor = Color.white
            $0.layer.cornerRadius = 15
            $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
    }
    
    func setLayouts(){
        addSubview(backgroundView)
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        backgroundView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
        }
        backgroundView.addSubview(todayButton)
        todayButton.snp.makeConstraints {
            $0.centerY.equalTo(dateLabel)
            $0.trailing.equalToSuperview().offset(-12)
            $0.width.equalTo(36)
            $0.height.equalTo(22)
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
            let maskPath = UIBezierPath(
                roundedRect: bounds,
                byRoundingCorners: corners,
                cornerRadii: CGSize(width: radius, height: radius))

            let shape = CAShapeLayer()
            shape.path = maskPath.cgPath
            layer.mask = shape
        }
    
    
    
}
