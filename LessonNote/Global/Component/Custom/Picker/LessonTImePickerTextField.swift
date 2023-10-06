//
//  DatePickerTextField.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/04.
//

import UIKit

class LessonTimePickerTextField: UITextField {
    
    let dateTimePicker = LessonTimePickerView()
    let arrowImageView = UIImageView()
    
    var toolbar: UIToolbar {
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "추가", style: .done, target: self, action: #selector(doneButtonTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.items = [flexibleSpace, doneButton]
        
        return toolbar
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setProperties()
        setLayouts()
    }
    
    func setProperties(){
//        backgroundColor = .systemPink
        dateTimePicker.do {
            $0.setup()
        }
        arrowImageView.do {
            $0.image = Image.arrowDown
        }

        inputView = dateTimePicker.inputView
        inputAccessoryView = toolbar
        text = "09:00 - 10:00"
        tintColor = .clear
        dateTimePicker.didSelectTimes = { [weak self] (startTime, endTime) in
            let timeRange = Date.buildTimeRangeString(startDate: startTime, endDate: endTime)
            print(timeRange)
            self?.text = timeRange
        }
    }
    
    func setLayouts(){
        addSubview(arrowImageView)
        snp.makeConstraints {
            $0.width.equalTo(130)
        }
        arrowImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
    
    @objc func doneButtonTapped() {
            endEditing(true)
        }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
