//
//  NumberPickerView.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/04.
//

import UIKit

final class NumberPickerView: NSObject {
    
    var didSelectNumber: ((_ number: Int) -> Void)?
    
    private lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()
    
    private let numbers: [Int] = Array(2...8)
    
    var inputView: UIView {
        return pickerView
    }
    
    func setup() {
        let defaultNumber = 2
        if let index = numbers.firstIndex(of: defaultNumber) {
            pickerView.selectRow(index, inComponent: 0, animated: false)
        }
        didSelectNumber?(defaultNumber)
    }
        
   
}

extension NumberPickerView: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // 하나의 컴포넌트만 사용합니다.
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numbers.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(numbers[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedNumber = numbers[row]
        didSelectNumber?(selectedNumber)
    }
}
