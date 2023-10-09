//
//  ScheduleViewController.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/01.
//

import UIKit

class ScheduleViewController: BaseViewController{
    
    private let scheduleView = ScheduleView()
    let scheduleViewModel = ScheduleViewModel()
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
        scheduleViewModel.courseItems.bind { _ in
            self.scheduleView.collectionView.reloadData()
        }
        scheduleView.timetableHeader.do {
            $0.dateLabel.text = scheduleViewModel.dateRangeOfWeek
            $0.todayButton.addTarget(self, action: #selector(todayButtonDidTap), for: .touchUpInside)
        }

    }
    
    @objc func todayButtonDidTap(){
        scrollToFirstPage()
    }
    
    func scrollToFirstPage(){
        let indexPath = IndexPath(item: 0, section: 0)
        scheduleView.collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
    }
    
}

extension ScheduleViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return scheduleViewModel.weekSchedules.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TimetableCell = collectionView.dequeReusableCell(forIndexPath: indexPath)
        cell.courseItems = scheduleViewModel.weekSchedules[indexPath.row].value                                                                                                                                         
        let daysofWeek = DateManager.shared.getDatesForWeek(numberOfWeeksFromThisWeek: indexPath.item)
        cell.daySymbol = DateManager.shared.formatDatesToENd(dates: daysofWeek)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.reloadData()
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let collectionView = scrollView as? UICollectionView {
            let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
            let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
            if let indexPath = collectionView.indexPathForItem(at: visiblePoint) {
                scheduleView.timetableHeader.dateLabel.text = DateManager.shared.getDateRange(numberOfWeeksFromThisWeek: indexPath.item)
            }
        }
    }
}
                                                  
