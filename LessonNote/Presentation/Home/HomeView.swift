//
//  HomeView.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/01.
//

import UIKit

class HomeView: BaseView{
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    let addStudentButton = UIButton()

    
    override func setProperties() {
        collectionView.do {
            $0.backgroundColor = .clear
        }
        addStudentButton.do {
            $0.setImage(Image.studentAdd, for: .normal)
        }

    }
    
    override func setLayouts() {
        addSubviews(collectionView, addStudentButton)
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
        addStudentButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-24)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).offset(-20)
        }
    }
    

 
    
    func createLayout() -> UICollectionViewLayout{
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100)) //estimated로 변경하기
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100)) //estimated로 변경하기
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 16
        section.contentInsets = NSDirectionalEdgeInsets(top: 18, leading: 20, bottom: 20, trailing: 18)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
}
