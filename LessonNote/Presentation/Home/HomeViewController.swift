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
    }
    
    override func setProperties() {
        view.backgroundColor = Color.gray1
        setDataSource()
        setSnapshot()
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
            print(itemIdentifier)
        }
        dataSource = UICollectionViewDiffableDataSource(collectionView: homeView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
}
