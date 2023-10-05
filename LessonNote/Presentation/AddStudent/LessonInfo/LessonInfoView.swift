//
//  LessonInfoView.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/02.
//

import UIKit

class LessonInfoView: BaseView {
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let weekdayContentView = CustomContentView(title: "요일", contentView: WeekdayStackView())
    let datePickerContentView = CustomContentView(title: "시간", contentView: DatePickerTextField())
    let weekCountContentView = CustomContentView(title: "격주 여부", contentView: WeekCountView())
    let nextButton = CompleteButton(title: "다음으로")
    
    override func setProperties() {
        titleLabel.do {
            let fullString = "수업 시간을\n알려주세요"
            let attrString = NSMutableAttributedString(string: fullString)
            let range = (fullString as NSString).range(of: "수업 시간")
            attrString.addAttribute(.font, value: Font.bold20, range: range)
            $0.font = Font.medium20
            $0.numberOfLines = 0
            $0.attributedText = attrString
        }
        descriptionLabel.do {
            $0.text = "나중에 자유롭게 변경할 수 있어요"
            $0.font = Font.medium12
            $0.textColor = Color.gray4
        }

    }
    
    override func setLayouts() {
        addSubviews(titleLabel, descriptionLabel, weekdayContentView, datePickerContentView, collectionView, weekCountContentView, nextButton)
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(25)
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(20)
        }
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(titleLabel)
        }
        weekdayContentView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(36.adjusted)
        }
        datePickerContentView.snp.makeConstraints {
            $0.leading.equalTo(weekdayContentView)
            $0.top.equalTo(weekdayContentView.snp.bottom).offset(36.adjusted)
        }
        collectionView.snp.makeConstraints {
            $0.leading.equalTo(datePickerContentView)
            $0.top.equalTo(datePickerContentView.snp.bottom).offset(12)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        weekCountContentView.snp.makeConstraints {
            $0.leading.equalTo(datePickerContentView)
            $0.top.equalTo(collectionView.snp.bottom).offset(36.adjusted)
            $0.width.equalTo(200)
            $0.height.equalTo(100)
        }
        
        nextButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().offset(-48)
        }
    }
    
    func createLayout() -> UICollectionViewLayout {
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(130.adjusted),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(134.adjusted),
            heightDimension: .absolute(30.adjusted)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: .zero, leading: .zero, bottom: .zero, trailing: 4.0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
}
