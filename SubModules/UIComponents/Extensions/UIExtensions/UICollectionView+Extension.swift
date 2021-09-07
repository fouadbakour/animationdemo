//
//  UICollectionView+Extension.swift
//  UIComponents
//
//  Created by Fouad Bakour on 05/09/2021.
//

import Foundation
import UIKit

public extension UICollectionView {
    func dequeueCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("DequeueReusableCell failed while casting")
        }
        return cell
    }
    
    func register<T: UICollectionViewCell>(_ : T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.identifier)
    }

    func registerNib<T: UICollectionViewCell>(_ : T.Type) {
        register(T.nib, forCellWithReuseIdentifier: T.identifier)
    }
    
    func register<T: UICollectionReusableView>(_ : T.Type) {
        register(T.self, forSupplementaryViewOfKind: T.identifier, withReuseIdentifier: T.identifier)
    }

    func registerNib<T: UICollectionReusableView>(_ : T.Type) {
        register(T.nib, forSupplementaryViewOfKind: T.identifier, withReuseIdentifier: T.identifier)
    }
    
    func endRefreshing() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.refreshControl?.endRefreshing()
            self.contentOffset = CGPoint(x: 0, y: 0)
        }
    }
    
    func beginRefreshing() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.refreshControl?.beginRefreshing()
            self.contentOffset = CGPoint(x: 0, y: -60)
        }
    }
    
    func setRefreshControl(color: UIColor = .darkGray, target: UIViewController, action: Selector?) {
        let uiRefreshControl = UIRefreshControl()
        uiRefreshControl.tintColor = color
        if let action = action {
            uiRefreshControl.addTarget(target, action: action, for: .valueChanged)
        }
        refreshControl = uiRefreshControl
    }
}
