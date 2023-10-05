//
//  LessonInfoViewController.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/02.
//

import UIKit

class LessonInfoViewController: BaseViewController {
    
    let lessonInfoView = LessonInfoView()
    let lessonInfoViewModel = LessonInfoViewModel()
    
    override func loadView() {
        self.view = lessonInfoView
    }
    
    override func setProperties() {
        hideKeyboardWhenTappedAround()
        lessonInfoView.collectionView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.register(cell: LessonTimeCell.self)
        }
        lessonInfoView.nextButton.addTarget(self, action: #selector(nextButtonDidTap), for: .touchUpInside)

    }
    
    override func setNavigationBar() {
        navigationItem.title = "학생 추가"
    }
    
    @objc func nextButtonDidTap(){
        let vc = StartDateInfoViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension LessonInfoViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: LessonTimeCell = collectionView.dequeReusableCell(forIndexPath: indexPath)
        return cell
    }
}
