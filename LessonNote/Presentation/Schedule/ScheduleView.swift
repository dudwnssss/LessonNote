//
//  ScheduleView.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/01.
//

import UIKit

final class ScheduleView: BaseView {
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    let timetableHeader = TimetableHeader()
    
    private func createLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.do {
            $0.scrollDirection = .horizontal
            $0.minimumLineSpacing = 0
        }
        collectionView.collectionViewLayout = layout

    }
    
    override func setProperties() {
        createLayout()
        collectionView.do {
            $0.register(cell: TimetableCell.self)
            $0.isPagingEnabled = true
            $0.showsHorizontalScrollIndicator = false
            $0.backgroundColor = .clear
        }
    }
    
    override func setLayouts() {
        addSubview(timetableHeader)
        timetableHeader.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(22)
            $0.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
        timetableHeader.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.equalTo(timetableHeader).offset(50)
            $0.width.equalTo(timetableHeader)
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}

