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
        homeView.collectionView.do {
            $0.dragInteractionEnabled = true
            $0.dragDelegate = self
            $0.dropDelegate = self
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


extension HomeViewController: UICollectionViewDragDelegate, UICollectionViewDropDelegate{
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return [] }
        let dragItem = UIDragItem(itemProvider: NSItemProvider())
        dragItem.localObject = item
        return [dragItem]
    }
    
    func collectionView(_ collectionView: UICollectionView, dragPreviewParametersForItemAt indexPath: IndexPath) -> UIDragPreviewParameters? {
        let params = UIDragPreviewParameters()
        params.backgroundColor = .clear
        return params
    }
    
    func collectionView(_ collectionView: UICollectionView, dragSessionWillBegin session: UIDragSession) {
        if let indexPath = collectionView.indexPathForItem(at: session.location(in: collectionView)) {
            collectionView.beginInteractiveMovementForItem(at: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, dragSessionDidEnd session: UIDragSession) {
        collectionView.endInteractiveMovement()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        if collectionView.hasActiveDrag {
            return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        return UICollectionViewDropProposal(operation: .forbidden)
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        guard let item = coordinator.items.first,
              let sourceIndexPath = item.sourceIndexPath,
              let destinationIndexPath = coordinator.destinationIndexPath else {
            return
        }
        
        collectionView.performBatchUpdates {
            homeViewModel.studentList.remove(at: sourceIndexPath.item)
            homeViewModel.studentList.insert(item.dragItem.localObject as! Student, at: destinationIndexPath.item)
            snapshot.deleteItems([item.dragItem.localObject as! Student])
            snapshot.insertItems([item.dragItem.localObject as! Student], beforeItem: snapshot.itemIdentifiers[destinationIndexPath.item])
            dataSource.apply(snapshot, animatingDifferences: false)
            coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
        }
    }
}
