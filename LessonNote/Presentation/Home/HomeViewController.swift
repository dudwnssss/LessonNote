//
//  HomeViewController.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/01.
//

import UIKit
import RealmSwift

class HomeViewController: BaseViewController{
    
    let homeView = HomeView()
    let homeViewModel = HomeViewModel()
    
    override func loadView() {
        self.view = homeView
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Int, Student>!
    
    override func setNavigationBar() {
        navigationItem.title = "홈"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: Image.setting, style: .plain, target: self, action: nil)
    }
    
    override func setProperties() {
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        view.backgroundColor = Color.gray1
        setDataSource()
        setSnapshot()
        homeView.addStudentButton.addTarget(self, action: #selector(addStudentButtonDidTap), for: .touchUpInside)
        homeViewModel.studentList.bind { _ in
            self.setSnapshot()
        }
        
    }
    
    @objc func addStudentButtonDidTap(){
        let vc = StudentInfoViewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            guard let selectedIndexPath = homeView.collectionView.indexPathForItem(at: gesture.location(in: homeView.collectionView)) else {
                return
            }
            homeView.collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
        case .changed:
            homeView.collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: homeView.collectionView))
        case .ended:
            homeView.collectionView.endInteractiveMovement()
        default:
            homeView.collectionView.cancelInteractiveMovement()
        }
    }
}

extension HomeViewController{
    
    private func setSnapshot(){
        var snapshot = NSDiffableDataSourceSnapshot<Int, Student>()
        snapshot.appendSections([0])
        snapshot.appendItems(homeViewModel.studentList.value)
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
