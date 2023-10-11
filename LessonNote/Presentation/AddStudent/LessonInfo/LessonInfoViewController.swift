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

        lessonInfoView.lessonTimeView.lessonTimePiker.passLessonTime = { start, end in
            print(start, end)
            print("하이", self.lessonInfoView.weekdayView.weekdayStackView.selectedWeekdays)

            self.lessonInfoView.weekdayView.weekdayStackView.selectedWeekdays.forEach {
                let lessonTime = LessonTime(weekday: $0, startTime: start, endTime: end)
                self.lessonInfoViewModel.lessonTimeList.append(lessonTime)
                self.lessonInfoView.collectionView.reloadData()
                self.lessonInfoView.weekdayView.weekdayStackView.weekdayButtons[$0.rawValue].isHidden = true
            }
            self.lessonInfoView.weekdayView.weekdayStackView.weekdayButtons.forEach { //선택해제
                $0.isActivated = false
            }
        }
        self.lessonInfoView.weekCountView.weekCountView.checkboxButton.addTarget(self, action: #selector(  checkboxButtonDidTap), for: .touchUpInside)
        
    }
    
    override func bind() {
        lessonInfoViewModel.isChecked.bind { value in
            self.lessonInfoView.weekCountView.weekCountView.checkboxButton.configureCheckbox(check: value)
            self.lessonInfoView.weekCountView.weekCountView.configureView(isChecked: value)
        }
        lessonInfoViewModel.weekCount.bind { value in
            self.lessonInfoView.weekCountView.weekCountView.textField.textField.text = "\(value)"
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
