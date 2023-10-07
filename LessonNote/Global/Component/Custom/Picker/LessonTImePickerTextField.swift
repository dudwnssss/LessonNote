//
//  DatePickerTextField.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/04.
//

import UIKit

class LessonTimePickerTextField: UITextField {
    
    var selectedStartTime: Date?
    var selectedEndTime: Date?
    
    let dateTimePicker = LessonTimePickerView()
    let arrowImageView = UIImageView()
    
    var passLessonTime: ((Date, Date) -> Void)?
    
    var toolbar: UIToolbar {
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "추가", style: .done, target: self, action: #selector(addButtonDidTap))
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
            self?.selectedStartTime = startTime
            self?.selectedEndTime = endTime
            let timeRange = Date.buildTimeRangeString(startDate: startTime, endDate: endTime)
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
    
    @objc func addButtonDidTap() {
            guard let selectedStartTime, let selectedEndTime else {return}
            passLessonTime?(selectedStartTime, selectedEndTime)
            endEditing(true)
        }
    
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
