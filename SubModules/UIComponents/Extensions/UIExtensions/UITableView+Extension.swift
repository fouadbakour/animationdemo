//
//  UITableView+Extension.swift
//  UIComponents
//
//  Created by Fouad Bakour on 05/09/2021.
//

import UIKit

public extension UITableView {
    
    func register<T: UITableViewCell>(_: T.Type) {
        register(T.nib, forCellReuseIdentifier: T.identifier)
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
            if self.refreshControl?.isRefreshing ?? false { return }
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
