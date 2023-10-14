//
//  LessonInfoView.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/02.
//

import UIKit

final class LessonInfoView: BaseView {
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let lessonTimeView = CustomLessonTimeView()
    let weekCountView = CustomWeekCountView()
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
        collectionView.do {
            $0.backgroundColor = .clear
        }

    }
    
    override func setLayouts() {
        addSubviews(titleLabel, descriptionLabel, lessonTimeView, collectionView, weekCountView, nextButton)
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(25)
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(20)
        }
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(titleLabel)
        }
        lessonTimeView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(25)
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(36.adjusted)
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
        
        nextButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().offset(-48.adjusted)
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
