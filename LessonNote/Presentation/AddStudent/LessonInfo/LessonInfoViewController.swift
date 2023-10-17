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
    private var dataSource: UICollectionViewDiffableDataSource<Int, LessonTime>!
    
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
        }
        lessonInfoView.nextButton.addTarget(self, action: #selector(nextButtonDidTap), for: .touchUpInside)
        lessonInfoView.lessonTimeView.textfield.delegate = self
        lessonInfoView.weekCountView.weekCountView.checkboxButton.addTarget(self, action: #selector(  checkboxButtonDidTap), for: .touchUpInside)
        setDataSource()
        setSnapshot()
    }
    
    override func bind() {
        lessonInfoViewModel.isChecked.bind { value in
            self.lessonInfoView.weekCountView.weekCountView.checkboxButton.configureCheckbox(check: value)
            self.lessonInfoView.weekCountView.weekCountView.configureView(isChecked: value)
        }
        lessonInfoViewModel.weekCount.bind { value in
            self.lessonInfoView.weekCountView.weekCountView.textField.textField.text = "\(value)"
        }
        lessonInfoViewModel.lessonTimeList.bind { _ in
            self.setSnapshot()
        }
    }
    
    override func setNavigationBar() {
        navigationItem.title = "학생 추가"
    }
    
    @objc func nextButtonDidTap(){
        lessonInfoViewModel.storeData()
        let vc = StartDateInfoViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func checkboxButtonDidTap(){
        lessonInfoViewModel.isChecked.value.toggle()
        lessonInfoViewModel.setWeekCount()
    }
}

extension LessonInfoViewController: UICollectionViewDelegate{
    
    private func setSnapshot(){
        var snapshot = NSDiffableDataSourceSnapshot<Int, LessonTime>()
        snapshot.appendSections([0])
        snapshot.appendItems(lessonInfoViewModel.lessonTimeList.value)
        dataSource.apply(snapshot)
    }
    
    private func setDataSource(){
        let cellRegistration = UICollectionView.CellRegistration<LessonTimeCell, LessonTime> { cell, indexPath, itemIdentifier in
        }
        dataSource = UICollectionViewDiffableDataSource(collectionView: lessonInfoView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            cell.configureCell(lessonTime: itemIdentifier)
            return cell
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        lessonInfoViewModel.lessonTimeList.value.remove(at: indexPath.item)
    }
}

extension LessonInfoViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let vc = LessonBottomSheetViewController()
        vc.delegate = self
        lessonInfoViewModel.lessonTimeList.value.forEach { lessons in
            vc.lessonBottomSheetViewModel.existWeekdays.append(lessons.weekday)
        }
        let bottomVC = BottomSheetViewController(contentViewController: vc)
        present(bottomVC, animated: true)
        return false
    }
}

extension LessonInfoViewController: PassLessonTimes {
    func passLessonTimes(lessons: [LessonTime]) {
        lessonInfoViewModel.lessonTimeList.value.append(contentsOf: lessons)
        lessonInfoViewModel.sortLessonTime()
    }
}
