//
//  LessonInfoViewController.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/02.
//

import UIKit

class LessonInfoViewController: BaseViewController, KeyboardEvent {
    
    var transformView: UIView {return self.view}
    let lessonInfoView = LessonInfoView()
    let lessonInfoViewModel = LessonInfoViewModel()
    
    override func loadView() {
        self.view = lessonInfoView
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeKeyboardObserver()
    }
    
    override func setProperties() {
        setupKeyboardEvent()
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
            }
            self.lessonInfoView.weekdayView.weekdayStackView.weekdayButtons.forEach {
                $0.isActivated = false
            }
        }
        
    }
    
    override func setNavigationBar() {
        navigationItem.title = "학생 추가"
    }
    
    @objc func nextButtonDidTap(){
        let vc = StartDateInfoViewController()
        navigationController?.pushViewController(vc, animated: true)
        TempStudent.shared.lessonTimes = lessonInfoViewModel.lessonTimeList
        TempStudent.shared.weekCount = lessonInfoView.weekCountView.weekCountView.selectedWeekCount
    }
}

extension LessonInfoViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lessonInfoViewModel.lessonTimeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: LessonTimeCell = collectionView.dequeReusableCell(forIndexPath: indexPath)
        cell.configureCell(lessonTime: lessonInfoViewModel.lessonTimeList[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        lessonInfoViewModel.lessonTimeList.remove(at: indexPath.item)
        collectionView.reloadData()
    }
}
