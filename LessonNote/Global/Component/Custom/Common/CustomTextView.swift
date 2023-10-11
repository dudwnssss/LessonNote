//
//  CustomTextView.swift
//  ARTISTACK
//
//  Created by 임영준 on 2023/08/31.
//

import UIKit
import SnapKit

class CustomTextView: BaseView {
    
    var placeholder: String? {
        didSet {
            setPlaceholder()
        }
    }
    
    var limitCount: Int = 0 {
        didSet {
            updateCountLabel()
        }
    }
    
    let textView = UITextView()
    let textCountLabel = UILabel()
    
    
    init(placeholder: String, limitCount: Int) {
        self.placeholder = placeholder
        self.limitCount = limitCount
        super.init(frame: .zero)
        textCountLabel.text = "\(limitCount)"
        setProperties()
        setLayouts()
    }
    
    override func setProperties() {
        textView.do {
            $0.textColor = Color.gray6
            $0.font = Font.medium14
            $0.delegate = self
            $0.isScrollEnabled = false
            $0.textContainerInset = .zero
            $0.textContainer.lineFragmentPadding = 0
            $0.backgroundColor = .clear
        }
        textCountLabel.do {
            $0.textColor = Color.gray4
            $0.textAlignment = .right
            $0.font = Font.medium14
        }
        setPlaceholder()
        backgroundColor = Color.gray1
        cornerRadius = 20
    }
    
    private func setPlaceholder() {
        if let placeholderText = placeholder {
            textView.text = placeholderText
            textView.textColor = Color.gray4
        }
    }
    
    override func setLayouts() {
        addSubviews(textCountLabel, textView)
        textCountLabel.snp.makeConstraints {
            $0.height.equalTo(18)
            $0.bottom.equalToSuperview().offset(-18)
            $0.trailing.equalToSuperview().offset(-20)
        }
        textView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalToSuperview().offset(18)
            $0.bottom.equalTo(textCountLabel.snp.top)
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomTextView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView.text == placeholder {
            textView.text = ""
            textView.textColor = Color.gray6
        }
        
        if let text = textView.text, text.count > limitCount {
            let index = text.index(text.startIndex, offsetBy: limitCount)
            textView.text = String(text.prefix(upTo: index))
        }
        updateCountLabel()
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView.text == placeholder {
            textView.text = ""
            textView.textColor = Color.gray6
        }
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        if textView.text.isEmpty {
            setPlaceholder()
        }
        return true
    }
    
    
    func updateCountLabel() {
        let remainingCount = limitCount - (textView.text?.count ?? 0)
        textCountLabel.text = "\(remainingCount)"
    }
}
