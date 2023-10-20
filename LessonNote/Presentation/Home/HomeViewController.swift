//
//  HomeViewController.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/01.
//

import UIKit
import RealmSwift

class HomeViewController: BaseViewController{
    
    private let homeView = HomeView()
    private let homeViewModel = HomeViewModel()
    private var dataSource: UICollectionViewDiffableDataSource<Int, Student>!

    override func loadView() {
        self.view = homeView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.standardAppearance.backgroundEffect = UIBlurEffect(style: .light)
    }
    
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
        homeView.collectionView.delegate = self
    }
    
    override func bind() {
        homeViewModel.studentList.bind { _ in
//            self.setDataSource()
            self.setSnapshot()
            self.setEmptyView()
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

extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = StudentViewController()
        vc.hidesBottomBarWhenPushed = true
        vc.studentViewModel.student.value = homeViewModel.studentList.value[indexPath.item]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setSnapshot(){
        var snapshot = NSDiffableDataSourceSnapshot<Int, Student>()
        snapshot.appendSections([0])
        snapshot.appendItems(homeViewModel.studentList.value)
        dataSource.apply(snapshot)
    }
    
    private func setEmptyView(){
        if homeViewModel.studentList.value.isEmpty{
            homeView.emptyView.isHidden = false
        } else {
            homeView.emptyView.isHidden = true
        }
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


