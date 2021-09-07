//
//  AppCartButton.swift
//  UIComponents
//
//  Created by Fouad Bakour on 07/09/2021.
//

import UIKit

// Presentable
public extension AppCartButton {
    
    struct Presentable {
        
        public let itemsCount: Int
        
        public init(itemsCount: Int) {
            self.itemsCount = itemsCount
        }
    }
}

// Protocols
public protocol AppCartButtonDataSource {
    func configure(for presentable: AppCartButton.Presentable)
    func incrementBy(_ newValue: Int)
    func decrementBy(_ newValue: Int)
}

// Class
public class AppCartButton: UIView {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var badgeView: UIView!
    @IBOutlet private weak var badgeLabel: AppLabel! {
        didSet {
            badgeLabel.style = .badge
            
        }
    }
    @IBOutlet private weak var iconImageView: AppImageView!
    
    // MARK: - Private Properties
    private(set) var currentCount: Int = -1 {
        didSet {
            badgeView.isHidden = currentCount == 0
        }
    }
    
    // MARK: - Initializers
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // MARK: - Common initializer
    func commonInit() {
        fromNib()
        containerView.makeCircular()
        badgeView.makeCircular()
    }
}

// MARK: - AppCartButton Data Source
extension AppCartButton: AppCartButtonDataSource {
    public func decrementBy(_ newValue: Int) {
        self.currentCount -= newValue
        self.badgeLabel.text = "\(self.currentCount)"
    }
    
    public func incrementBy(_ newValue: Int) {
        self.badgeView.isHidden = false
        self.badgeView.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.badgeView.transform = .identity
            self.currentCount += newValue
            self.badgeLabel.text = "\(self.currentCount)"
        }, completion: nil)
    
    }
    
    public func configure(for presentable: Presentable) {
        currentCount = presentable.itemsCount
        badgeLabel.text = "\(currentCount)"
    }
}
