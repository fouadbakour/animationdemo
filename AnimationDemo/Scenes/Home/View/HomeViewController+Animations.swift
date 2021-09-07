//
//  HomeViewController+Animations.swift
//  AnimationDemo
//
//  Created by Fouad Bakour on 07/09/2021.
//

import Foundation
import UIKit
import UIComponents

extension HomeViewController {
    
    // MARK: - Configure animations
    func configureAnimations() {
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight.direction = .right
        tableView.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeLeft.direction = .left
        tableView.addGestureRecognizer(swipeLeft)
    }
    
    func animateSliding(direction: UISwipeGestureRecognizer.Direction, segmentIndex: Int, segmentTabs: [HomeUIModel.Segment]) {
        
        tableViewCenterX.constant = direction == .right ? (tableView.frame.width) : -(tableView.frame.width)
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [.transitionFlipFromRight], animations: { [weak self] in
            guard let self = self else { return }
            self.view.layoutIfNeeded()
            self.tableView.alpha = 0
        }, completion: { done in})
        delay(0.1) { [weak self] in
            guard let self = self else { return }
            self.sections = []
            self.tableViewCenterX.constant = direction == .right ? -(self.tableView.frame.width) : (self.tableView.frame.width)
            self.view.layoutIfNeeded()
            self.tableViewCenterX.constant = 0
            
            // Change content
            self.headerView.setSelectedId(id: segmentTabs[segmentIndex].id)
            self.shouldFilterSubject.onNext(segmentTabs[segmentIndex].id)
            
            UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [.transitionFlipFromRight], animations: { [weak self] in
                guard let self = self else { return }
                self.tableView.alpha = 1
                self.view.layoutIfNeeded()
            }, completion: { done in
                self.tableView.setContentOffset(.init(x: 0, y: 450), animated: true)
            })
        }
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            let segmentTabs = sections.first(where: { $0.type == .segment })?.segments ?? []
            switch swipeGesture.direction {
            case .right:
                let currentIndex = segmentTabs.firstIndex(where: { $0.id == defaultCategoryId }) ?? 0
                let previousIndex = segmentTabs.index(before: currentIndex)
                let isIndexValid = segmentTabs.indices.contains(previousIndex)
                if isIndexValid {
                    animateSliding(direction: .right, segmentIndex: previousIndex, segmentTabs: segmentTabs)
                }
            
            case .left:
                let currentIndex = segmentTabs.firstIndex(where: { $0.id == defaultCategoryId }) ?? 0
                let nextIndex = segmentTabs.index(after: currentIndex)
                let isIndexValid = segmentTabs.indices.contains(nextIndex)
                if isIndexValid {
                    animateSliding(direction: .left, segmentIndex: nextIndex, segmentTabs: segmentTabs)
                }
            default:
                break
            }
        }
    }
}
