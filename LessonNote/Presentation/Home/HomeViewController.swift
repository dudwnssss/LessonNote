//
//  HomeViewController.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/01.
//

import UIKit

class HomeViewController: BaseViewController{
    
    let homeView = HomeView()
    let homeViewModel = HomeViewModel()
    
    override func loadView() {
        self.view = homeView
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Int, Student>!
    var snapshot = NSDiffableDataSourceSnapshot<Int, Student>()
    
    override func setNavigationBar() {
        navigationItem.title = "홈"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: Image.setting, style: .plain, target: self, action: nil)
    }
    
    override func setProperties() {
        view.backgroundColor = Color.gray1
        setDataSource()
        setSnapshot()
        homeView.addStudentButton.addTarget(self, action: #selector(addStudentButtonDidTap), for: .touchUpInside)
    }
    
    @objc func addStudentButtonDidTap(){
        let vc = StudentInfoViewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController{
    
    private func setSnapshot(){
        snapshot.appendSections([0])
        snapshot.appendItems(homeViewModel.studentList)
        dataSource.apply(snapshot)
    }
    
    private func setDataSource(){
        let cellRegistration = UICollectionView.CellRegistration<StudentCollectionViewCell, Student> { cell, indexPath, itemIdentifier in
        }
        dataSource = UICollectionViewDiffableDataSource(collectionView: homeView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            cell.configureCell(student: itemIdentifier)
            return cell
        })
    }
}
