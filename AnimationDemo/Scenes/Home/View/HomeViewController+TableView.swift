//
//  HomeViewController+TableView.swift
//  AnimationDemo
//
//  Created by Fouad Bakour on 05/09/2021.
//

import Foundation
import UIKit
import UIComponents

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = sections[section]
        return section.numberOfRows
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = sections[indexPath.section]
        switch section.type {
        case .slider, .segment:
            return 0
        default:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        switch section.type {
        case .foodItems:
            let cell = ProductTableViewCell.dequeueReusableCell(in: tableView, indexPath: indexPath)
            let item = section.foodItems[indexPath.row]

            cell.appProductView?.configure(for: .init(title: item.attributedTitle,
                                                      description: item.desc ?? "",
                                                      imageUrl: item.imageURL ?? "",
                                                      ingredients: item.description,
                                                      price: item.price ?? "",
                                                      id: item.id ?? ""))
            cell.appProductView?.delegate = self
            return cell
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        headerView.scrollViewDidScroll(scrollView: scrollView)
    }
}

// MARK: - AppProductViewDelegate
extension HomeViewController: AppProductViewDelegate {
    func didTapPriceButton(view: AppProductView, button: AppButton, id: String) {
        button.animateDidAddItem(currentStyle: button.style, currentText: button.currentTitle ?? "")
        cartButton.incrementBy(1)
        
        // TODO: - Call add to cart API ...
        // On success, do nothing
        // On fail, call "cartButton.decrementBy(1)"
    }
}
