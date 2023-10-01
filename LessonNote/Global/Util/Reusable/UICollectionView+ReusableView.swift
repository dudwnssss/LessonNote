//
//  UICollectionView+ReusableView.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/01.
//

import UIKit

extension UICollectionReusableView: ReusableView {}

extension UICollectionView{
    
    func dequeReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T
        else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
    
    func dequeHeaderView<T: UICollectionReusableView>(forIndexPath indexPath: IndexPath) -> T {
        guard let view = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return view
    }
    
    func register<T>(
        cell: T.Type,
        forCellWithReuseIdentifier reuseIdentifier: String = T.reuseIdentifier) where T: UICollectionViewCell {
            register(cell, forCellWithReuseIdentifier: reuseIdentifier)
        }
    
    func register<T>(
        header: T.Type,
        forCellWithReuseIdentifier reuseIdentifier: String = T.reuseIdentifier) where T: UICollectionReusableView{
            register(header, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: reuseIdentifier)
        }
}
