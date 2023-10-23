//
//  MemoView.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/23.
//

import UIKit

final class MemoView: BaseView {
    
    private let punchImageView = UIImageView()
    private let backgroundView = UIView()
    let textView = UnderlinedTextView()
    
    override func setProperties() {
        punchImageView.do {
            $0.image = Image.notePunchedSmall
            $0.contentMode = .scaleAspectFill
        }
        backgroundView.do {
            $0.backgroundColor = Color.white
            $0.clipsToBounds = true
            $0.cornerRadius = 20
            $0.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        }
        
    }
    
    override func setLayouts() {
        addSubviews(punchImageView, backgroundView)
        backgroundView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(48)
            $0.height.equalTo(backgroundView.snp.width).multipliedBy(423/278)
        }
        punchImageView.snp.makeConstraints {
            $0.bottom.equalTo(backgroundView.snp.top)
            $0.horizontalEdges.equalTo(backgroundView)
        }
        
    }
    
}

final class UnderlinedTextView: UITextView {
  var lineHeight: CGFloat = 13.8

  override var font: UIFont? {
    didSet {
      if let newFont = font {
        lineHeight = newFont.lineHeight
      }
    }
  }

  override func draw(_ rect: CGRect) {
    let ctx = UIGraphicsGetCurrentContext()
    ctx?.setStrokeColor(UIColor.black.cgColor)
    let numberOfLines = Int(rect.height / lineHeight)
    let topInset = textContainerInset.top

    for i in 1...numberOfLines {
      let y = topInset + CGFloat(i) * lineHeight

      let line = CGMutablePath()
      line.move(to: CGPoint(x: 0.0, y: y))
      line.addLine(to: CGPoint(x: rect.width, y: y))
      ctx?.addPath(line)
    }

    ctx?.strokePath()

    super.draw(rect)
  }
}
