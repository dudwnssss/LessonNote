//
//  DatePickerVIew.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/04.
//


import UIKit

class DateTimePicker: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var didSelectTimes: ((_ start: Date, _ end: Date) -> Void)?
    
    private lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()
    
    private var startHours = [Int]()
    private var startMinutes = [Int]()
    private var endHours = [Int]()
    private var endMinutes = [Int]()
    
    let timeFormatter = DateFormatter()
    
    var inputView: UIView {
        return pickerView
    }
    
    func setup() {
        timeFormatter.timeStyle = .short
        
        // Populate the arrays with hours and minutes
        startHours = Array(0...23)
        startMinutes = Array(0...59)
        endHours = Array(0...23)
        endMinutes = Array(0...59)
        
        pickerView.selectRow(startHours[9], inComponent: 0, animated: false)
        pickerView.selectRow(endHours[10], inComponent: 2, animated: false)
        pickerView.setPickerLabelsWith(labels: ["시", "분", "시", "분"])


    }
    
    // MARK: - UIPickerViewDelegate & DateSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4 // Four components: start hour, start minute, end hour, end minute
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return startHours.count // Start hour
        case 1:
            return startMinutes.count // Start minute
        case 2:
            return endHours.count // End hour
        case 3:
            return endMinutes.count // End minute
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label: UILabel
        
        if let view = view as? UILabel {
            label = view
        } else {
            label = UILabel()
        }
        
        label.textColor = Color.gray6
        label.textAlignment = .center
        label.font = Font.medium14
        
        var text = ""
        
        switch component {
        case 0:
            text = "\(startHours[row])" // Display start hour
        case 1:
            text = String(format: "%02d", startMinutes[row])
        case 2:
            text = "\(endHours[row])" // Display end hour
        case 3:
            text = String(format: "%02d", endMinutes[row])
        default:
            break
        }
        
        label.text = text
        
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedStartHour = startHours[pickerView.selectedRow(inComponent: 0)]
        let selectedStartMinute = startMinutes[pickerView.selectedRow(inComponent: 1)]
        let selectedEndHour = endHours[pickerView.selectedRow(inComponent: 2)]
        let selectedEndMinute = endMinutes[pickerView.selectedRow(inComponent: 3)]
        
        let calendar = Calendar.current
        let currentDate = Date()
        
        // Create start and end date components
        var startComponents = calendar.dateComponents([.year, .month, .day], from: currentDate)
        startComponents.hour = selectedStartHour
        startComponents.minute = selectedStartMinute
        
        var endComponents = calendar.dateComponents([.year, .month, .day], from: currentDate)
        endComponents.hour = selectedEndHour
        endComponents.minute = selectedEndMinute
        
        // Create start and end dates
        let startTime = calendar.date(from: startComponents)!
        let endTime = calendar.date(from: endComponents)!
        
        didSelectTimes?(startTime, endTime)
    }
}


