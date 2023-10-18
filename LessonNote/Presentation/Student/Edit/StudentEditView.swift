//
//  StudentEditView.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/17.
//

import UIKit

final class StudentEditView: BaseView {
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    let studentNameView = CustomStudentNameView()
    let studentIconView = CustomStudentIconView()
    let studentPhoneNumberView = CustomStudentPhoneNumberView()
    let parentPhoneNumberView = CustomParentPhoneNumberView()
    let lessonTimeView = CustomLessonTimeView()
    let weekCountView = CustomWeekCountView()
    private let startDateLabel = CustomTitleLabel(title: "수업 시작일")
    let startWeekdayView = CustomStartWeekdayView()
    let startDateTextField = UITextField()
    private let arrowImageView = UIImageView()
    let deleteStudentButton = UIButton()
    let underlineView = UIView()
    
    let completeButton = CompleteButton(title: "편집 완료")
    
    
    override func setProperties() {
        startDateTextField.do {
            $0.textColor = Color.gray6
            $0.tintColor = .clear
            $0.text = "월 09:00 - 10:00"
        }
        arrowImageView.do {
            $0.image = Image.arrowDown
        }
        deleteStudentButton.do {
            $0.setTitle("학생 삭제하기", for: .normal)
            $0.setTitleColor(Color.gray4, for: .normal)
            $0.titleLabel?.font = Font.bold14
            $0.setUnderline()
        }
        startDateTextField.do {
            $0.textColor = Color.gray6
            $0.font = Font.medium14
        }


    }
    
    override func setLayouts() {
        addSubviews(scrollView, completeButton)
        scrollView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
        scrollView.addSubview(contentView)
        
        contentView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.centerX.top.bottom.equalToSuperview()
        }
        
        contentView.addSubviews(studentNameView, studentIconView, studentPhoneNumberView, parentPhoneNumberView, lessonTimeView
        , collectionView, weekCountView, startDateLabel, startDateTextField, startWeekdayView, deleteStudentButton)
        
        studentNameView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalToSuperview().offset(18)
        }
        
        studentIconView.snp.makeConstraints {
            $0.leading.equalTo(studentNameView)
            $0.top.equalTo(studentNameView.snp.bottom).offset(36)
        }
        
        studentPhoneNumberView.snp.makeConstraints {
            $0.leading.equalTo(studentNameView)
            $0.top.equalTo(studentIconView.snp.bottom).offset(36)
        }
        parentPhoneNumberView.snp.makeConstraints {
            $0.leading.equalTo(studentNameView)
            $0.top.equalTo(studentPhoneNumberView.snp.bottom).offset(36)
        }
        lessonTimeView.snp.makeConstraints {
            $0.leading.equalTo(studentNameView)
            $0.top.equalTo(parentPhoneNumberView.snp.bottom).offset(36)
            $0.height.equalTo(70)
        }
        collectionView.snp.makeConstraints {
            $0.top.equalTo(lessonTimeView.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(30)
        }
        weekCountView.snp.makeConstraints {
            $0.leading.equalTo(lessonTimeView)
            $0.top.equalTo(collectionView.snp.bottom).offset(36.adjusted)
        }
        startDateLabel.snp.makeConstraints {
            $0.leading.equalTo(studentNameView)
            $0.top.equalTo(weekCountView.snp.bottom).offset(36)
        }
        startDateTextField.snp.makeConstraints {
            $0.top.equalTo(startDateLabel.snp.bottom).offset(16)
            $0.leading.equalTo(studentNameView)
            $0.width.equalTo(156)
        }
        startDateTextField.addSubview(arrowImageView)
        arrowImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        startWeekdayView.snp.makeConstraints {
            $0.leading.equalTo(studentNameView)
            $0.top.equalTo(startDateTextField.snp.bottom).offset(36)
            $0.height.equalTo(80)
        }
        deleteStudentButton.snp.makeConstraints {
            $0.leading.equalTo(studentNameView)
            $0.top.equalTo(startWeekdayView.snp.bottom).offset(36)
            $0.bottom.equalToSuperview().offset(-150)
        }
        
        completeButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().offset(-48)
        }
    }
    
    private func createLayout() -> UICollectionViewLayout {
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(130.adjusted),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(134.adjusted),
            heightDimension: .fractionalHeight(1)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: .zero, leading: .zero, bottom: .zero, trailing: 4.0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 25.0, bottom: 0, trailing: 0)

        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
}
