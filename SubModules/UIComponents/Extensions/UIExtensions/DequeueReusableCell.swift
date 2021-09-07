//
//  UICollectionViewCell+Extension.swift
//  UIComponents
//
//  Created by Fouad Bakour on 05/09/2021.
//

import UIKit

public protocol DequeueReusable {
    static func dequeueReusableCell(in view: UIView, indexPath: IndexPath) -> Self
}

extension UICollectionViewCell: DequeueReusable { }

public extension DequeueReusable where Self: UICollectionViewCell {
    
    static func dequeueReusableCell(in view: UIView, indexPath: IndexPath) -> Self {
        guard let collectionView = view as? UICollectionView,
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Self.identifier, for: indexPath) as? Self else {
            return Self()
        }
        return cell
    }
}

extension UITableViewCell: DequeueReusable { }

public extension DequeueReusable where Self: UITableViewCell {
    
    static func dequeueReusableCell(in view: UIView, indexPath: IndexPath) -> Self {
        guard let tableView = view as? UITableView, let cell = tableView.dequeueReusableCell(withIdentifier: Self.identifier, for: indexPath) as? Self else { return Self() }
        return cell
    }
}
