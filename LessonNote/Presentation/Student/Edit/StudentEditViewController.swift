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
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, LessonTime>!

    override func setProperties() {
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
        viewModel.lessonTimeList.bind {[weak self] _ in
            self?.setSnapshot()
        }

        viewModel.startDate.bind {[weak self] date in
            self?.studentEditView.startDateTextField.text = DateManager.shared.formatFullDateToString(date: date!)
        }
        viewModel.weekday.bind {[weak self] weekday in
            self?.studentEditView.startWeekdayView.descriptionLabel.text = weekday.title+"요일을 기준으로 주차가 반복됩니다."
            self?.studentEditView.startWeekdayView.weekdayStackView.weekdayButtons.forEach { button in
                print(button)
                button.configureButton(activate: button.tag == weekday.rawValue)
            }
        }
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
