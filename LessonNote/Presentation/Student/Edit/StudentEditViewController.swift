//
//  StudentEditViewController.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/17.
//

import UIKit


final class StudentEditViewController: BaseViewController {
    
    private let studentEditView = StudentEditView()
    let viewModel = StudentEditViewModel()
    
    override func loadView() {
        self.view = studentEditView
    }
    
    var delegate: PassData?
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, LessonTime>!

    override func setProperties() {
        studentEditView.studentNameView.textfieldView.textField.addTarget(self, action: #selector(nameTextFieldDidChange), for: .editingChanged)
        studentEditView.studentIconView.iconStackView.studentIconButtonList.forEach { button in
            button.addTarget(self, action: #selector(studentIconButtonDidTap(sender:)), for: .touchUpInside)
        }
        studentEditView.studentPhoneNumberView.textfieldView.textField.addTarget(self, action: #selector(studentNumberTextFieldDidChange), for: .editingChanged)
        
        studentEditView.parentPhoneNumberView.textfieldView.textField.addTarget(self, action: #selector(parentNumberTextFieldDidChange), for: .editingChanged)
        
        studentEditView.weekCountView.weekCountView.checkboxButton.addTarget(self, action: #selector(checkboxButtonDidTap), for: .touchUpInside)
        
        studentEditView.startWeekdayView.weekdayStackView.weekdayButtons.forEach { button in
            button.addTarget(self, action: #selector(weekdayButtonDidTap(sender:)), for: .touchUpInside)
        }
        studentEditView.completeButton.addTarget(self, action: #selector(completeButtonDidTap), for: .touchUpInside)
        
        studentEditView.weekCountView.weekCountView.numberPickerView.didSelectNumber = {
            number in
            self.viewModel.weekCount.value = number
        }
        studentEditView.deleteStudentButton.addTarget(self, action: #selector(deleteButtonDidTap), for: .touchUpInside)
        studentEditView.datePickerView.minimumDate = viewModel.startDate.value
        studentEditView.datePickerView.addTarget(self, action: #selector(datePickerDidChange), for: .valueChanged)
        studentEditView.lessonTimeView.textfield.delegate = self
        studentEditView.collectionView.delegate = self
        setDataSource()
        setSnapshot()
    }
    
    override func setNavigationBar() {
        navigationItem.title = "학생 편집"
    }
    
    override func bind() {
        viewModel.student.bind {[weak self] _ in
            self?.viewModel.setStudent()
        }
        viewModel.name.bind {[weak self] name in
            self?.studentEditView.studentNameView.textfieldView.textField.text = name
        }
        viewModel.studentIcon.bind { value in
            self.studentEditView.studentIconView.iconStackView.studentIconButtonList.forEach({
                $0.configureButton(isSelected: value == $0.studentIcon)
            })
        }
        viewModel.studentPhoneNumber.bind { [weak self] value in
            self?.studentEditView.studentPhoneNumberView.textfieldView.textField.text = value
        }
        viewModel.parentPhoneNumber.bind { [weak self] value in
            self?.studentEditView.parentPhoneNumberView.textfieldView.textField.text = value
        }
        viewModel.isChecked.bind {[weak self] value in
            self?.studentEditView.weekCountView.weekCountView.checkboxButton.configureCheckbox(check: value)
            self?.studentEditView.weekCountView.weekCountView.configureView(isChecked: value)
        }
        viewModel.weekCount.bind {[weak self] value in
            self?.studentEditView.weekCountView.weekCountView.textField.textField.text = "\(value)"
        }
        viewModel.lessonTimeList.bind {[weak self] lessons in
            self?.setSnapshot()
            self?.studentEditView.startWeekdayView.weekdayStackView.configureStackView(weekdays: lessons.map{$0.weekday}, hide: false)
            self?.viewModel.setInitialWeekdays()
        }
        viewModel.startDate.bind {[weak self] date in
            self?.studentEditView.startDateTextField.text = DateManager.shared.formatFullDateToString(date: date)
            self?.studentEditView.datePickerView.date = date
        }
        viewModel.weekday.bind {[weak self] weekday in
            self?.studentEditView.startWeekdayView.descriptionLabel.text = weekday.title+"요일을 기준으로 주차가 반복됩니다."
            self?.studentEditView.startWeekdayView.weekdayStackView.weekdayButtons.forEach { button in
                button.configureButton(activate: button.tag == weekday.rawValue)
            }
        }
    }
    
    @objc func nameTextFieldDidChange(){
        if let text = studentEditView.studentNameView.textfieldView.textField.text {
            viewModel.name.value = text
        }
    }
    @objc func studentIconButtonDidTap(sender: StudentIconButton){
        guard let icon = sender.studentIcon else {return}
        viewModel.studentIcon.value = icon
    }
    @objc func studentNumberTextFieldDidChange(){
        if let text = studentEditView.studentPhoneNumberView.textfieldView.textField.text {
            viewModel.studentPhoneNumber.value = text
        }
    }
    @objc func parentNumberTextFieldDidChange(){
        if let text = studentEditView.parentPhoneNumberView.textfieldView.textField.text {
            viewModel.parentPhoneNumber.value = text
        }
    }
    @objc func checkboxButtonDidTap(){
        viewModel.isChecked.value.toggle()
        viewModel.setWeekCount()
    }
    @objc func weekdayButtonDidTap(sender: CustomButton) {
        viewModel.weekday.value = Weekday(rawValue: sender.tag)!
    }
    @objc func datePickerDidChange(){
        viewModel.startDate.value = studentEditView.datePickerView.date
    }
    
    @objc func deleteButtonDidTap(){
        let alert = UIAlertController(title: "학생 삭제하기", message: "학생을 삭제하시면, 수업기록이 모두 삭제되고 학생목록에서도 삭제됩니다.", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let delete = UIAlertAction(title: "삭제하기", style: .destructive) { _ in
            self.viewModel.delete()
            self.navigationController?.popToRootViewController(animated: true)
        }
        alert.addAction(cancel)
        alert.addAction(delete)
        present(alert, animated: true)
    }
    
    @objc func completeButtonDidTap(){
        viewModel.update()
        delegate?.passData()
        navigationController?.popViewController(animated: true)
    }
    
}

extension StudentEditViewController: UICollectionViewDelegate{
    
    private func setSnapshot(){
        var snapshot = NSDiffableDataSourceSnapshot<Int, LessonTime>()
        snapshot.appendSections([0])
        snapshot.appendItems(viewModel.lessonTimeList.value)
        dataSource.apply(snapshot)
    }
    
    private func setDataSource(){
        let cellRegistration = UICollectionView.CellRegistration<LessonTimeCell, LessonTime> { cell, indexPath, itemIdentifier in
        }
        dataSource = UICollectionViewDiffableDataSource(collectionView: studentEditView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            cell.configureCell(lessonTime: itemIdentifier)
            return cell
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.lessonTimeList.value.remove(at: indexPath.item)
    }
}

extension StudentEditViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let vc = LessonBottomSheetViewController()
        vc.delegate = self
        vc.lessonBottomSheetViewModel.existWeekdays.append(contentsOf: viewModel.weekdays.value)
        let bottomVC = BottomSheetViewController(contentViewController: vc)
        present(bottomVC, animated: true)
        return false
    }
}

extension StudentEditViewController: PassLessonTimes {
    func passLessonTimes(lessons: [LessonTime]) {
        viewModel.lessonTimeList.value.append(contentsOf: lessons)
        viewModel.sortLessonTime()
    }
}
