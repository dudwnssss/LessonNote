//
//  ScheduleViewController.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/01.
//

import UIKit

final class ScheduleViewController: BaseViewController{
    
    private let scheduleView = ScheduleView()
    private let scheduleViewModel = ScheduleViewModel()
    override func loadView() {
        self.view = scheduleView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.standardAppearance.backgroundEffect = UIBlurEffect(style: .light)
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
        scheduleViewModel.weekSchedules.bind { _ in
            self.scheduleView.collectionView.reloadData()
        }
        scheduleView.timetableHeader.do {
            $0.dateLabel.text = DateManager.shared.getDateRange(numberOfWeeksFromThisWeek: 0)
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
        return scheduleViewModel.weekSchedules.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TimetableCell = collectionView.dequeReusableCell(forIndexPath: indexPath)
        cell.delegate = self
        cell.courseItems = scheduleViewModel.weekSchedules.value[indexPath.row]
        let daysofWeek = DateManager.shared.getDatesForWeek(numberOfWeeksFromThisWeek: indexPath.item)
        cell.daySymbol = DateManager.shared.formatDatesToENd(dates: daysofWeek)
        return cell
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
                                                  
extension ScheduleViewController: PassStudent {
    func passStudent(student: Student) {
        let vc = StudentViewController()
        vc.studentViewModel.student.value = student
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
