//
//  LessonInfoViewController.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/02.
//

import UIKit

final class LessonInfoViewController: BaseViewController {
    
    private let lessonInfoView = LessonInfoView()
    private let lessonInfoViewModel = LessonInfoViewModel()
    
    override func loadView() {
        self.view = lessonInfoView
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func setProperties() {
        hideKeyboardWhenTappedAround()
        lessonInfoView.collectionView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.register(cell: LessonTimeCell.self)
        }
        lessonInfoView.nextButton.addTarget(self, action: #selector(nextButtonDidTap), for: .touchUpInside)
        lessonInfoView.lessonTimeView.textfeild.delegate = self
        
        
//        lessonInfoView.lessonTimeView.lessonTimePiker.passLessonTime = { start, end in
//            self.lessonInfoViewModel.weekDays.value.forEach {
//                let lessonTime = LessonTime(weekday: $0, startTime: start, endTime: end)
//                self.lessonInfoViewModel.lessonTimeList.append(lessonTime)
//                self.lessonInfoView.collectionView.reloadData()
//                self.lessonInfoView.weekdayView.weekdayStackView.weekdayButtons[$0.rawValue].isHidden = true
//            }
//        }
        
        
        lessonInfoView.weekCountView.weekCountView.checkboxButton.addTarget(self, action: #selector(  checkboxButtonDidTap), for: .touchUpInside)
        lessonInfoView.weekdayView.weekdayStackView.weekdayButtons.forEach {
            $0.addTarget(self, action: #selector(weekdayButtonDidTap(sender:)), for: .touchUpInside)
        }
        
    }
    
    override func bind() {
        lessonInfoViewModel.isChecked.bind { value in
            self.lessonInfoView.weekCountView.weekCountView.checkboxButton.configureCheckbox(check: value)
            self.lessonInfoView.weekCountView.weekCountView.configureView(isChecked: value)
        }
        lessonInfoViewModel.weekCount.bind { value in
            self.lessonInfoView.weekCountView.weekCountView.textField.textField.text = "\(value)"
        }
        lessonInfoViewModel.weekDays.bind { weekdays in
            self.lessonInfoView.weekdayView.weekdayStackView.weekdayButtons.forEach {
                guard let weekday = Weekday(rawValue: $0.tag) else {return}
                $0.configureButton(activate: (weekdays.contains(weekday)))
            }
        }
    }
    override func setNavigationBar() {
        navigationItem.title = "학생 추가"
    }
    
    @objc func nextButtonDidTap(){
        let vc = StartDateInfoViewController()
        navigationController?.pushViewController(vc, animated: true)
        lessonInfoViewModel.storeData()
    }
    
    @objc func checkboxButtonDidTap(){
        lessonInfoViewModel.isChecked.value.toggle()
        lessonInfoViewModel.setWeekCount()
    }
    @objc func weekdayButtonDidTap(sender: CustomButton){
        lessonInfoViewModel.appendWeekday(tag: sender.tag)
    }
}

extension LessonInfoViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lessonInfoViewModel.lessonTimeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: LessonTimeCell = collectionView.dequeReusableCell(forIndexPath: indexPath)
        let lessonTime = lessonInfoViewModel.lessonTimeList[indexPath.item]
        cell.configureCell(lessonTime: lessonTime)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = lessonInfoViewModel.lessonTimeList[indexPath.item].weekday.rawValue
        lessonInfoViewModel.lessonTimeList.remove(at: indexPath.item)
        lessonInfoView.weekdayView.weekdayStackView.weekdayButtons[index].isHidden = false
        collectionView.reloadData()
    }
}

extension LessonInfoViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let vc = LessonBottomSheetViewController()
        vc.delegate = self
        lessonInfoViewModel.lessonTimeList.forEach { lessons in
            vc.lessonBottomSheetViewModel.existWeekdays.append(lessons.weekday)
        }
        let bottomVC = BottomSheetViewController(contentViewController: vc)
        present(bottomVC, animated: true)
        return false
    }
}

extension LessonInfoViewController: PassLessonTimes {
    func passLessonTimes(lessons: [LessonTime]) {
        lessonInfoViewModel.lessonTimeList.append(contentsOf: lessons)
        lessonInfoView.collectionView.reloadData()
        
    }
}
