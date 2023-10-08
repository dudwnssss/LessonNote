//
//  ScheduleViewController.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/01.
//

import UIKit

class ScheduleViewController: BaseViewController{
    
    let scheduleView = ScheduleView()
    override func loadView() {
        self.view = scheduleView
    }
    
    override func setNavigationBar() {
        navigationItem.title = "일정표"
    }
    
    override func setProperties() {
        view.backgroundColor = Color.gray1
        scheduleView.collectionView.do {
            $0.delegate = self
            $0.dataSource = self
        }

    }
    
}

extension ScheduleViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }


    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TimetableCell = collectionView.dequeReusableCell(forIndexPath: indexPath)
        return cell
    }
    
}
