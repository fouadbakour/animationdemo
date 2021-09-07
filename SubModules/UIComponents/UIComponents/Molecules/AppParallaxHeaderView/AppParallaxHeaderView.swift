//
//  AppParallaxHeaderView.swift
//  UIComponents
//
//  Created by Fouad Bakour on 06/09/2021.
//

import UIKit

// Protocols
public protocol AppParallaxHeaderViewDataSource {
    func configure(slider: AppSlideShow.Presentable, segment: AppSegment.Presentable)
    func setSelectedId(id: String)
    func scrollViewDidScroll(scrollView: UIScrollView)
    func hasContent() -> Bool
}

public protocol AppParallaxHeaderViewDelegate: AnyObject {
    func didSelectItem(id: String)
}

// Class
public class AppParallaxHeaderView: UIView {
    
    // MARK: - Outlets
    @IBOutlet private weak var containerHightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var slideShowHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var segmentHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var slideShowBottomConstraint: NSLayoutConstraint!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var slideShowView: AppSlideShow!
    @IBOutlet private weak var appSegmentContainer: UIView!
    @IBOutlet private weak var appSegment: AppSegment!
    
    // MARK: - Private Properties
    private(set) var itemsCount: Int = 0
    
    // MARK: - Public Properties
    public weak var delegate: AppParallaxHeaderViewDelegate?
    
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
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.appSegmentContainer?.roundCorners([.topLeft, .topRight], radius: 20)
        }
    }
}

extension AppParallaxHeaderView: AppSegmentDelegate {
    public func didSelectItem(id: String) {
        delegate?.didSelectItem(id: id)
    }
}

// MARK: - AppParallaxHeaderView Data Source
extension AppParallaxHeaderView: AppParallaxHeaderViewDataSource {
    public func setSelectedId(id: String) {
        appSegment.setSelectedId(id: id)
    }
    
    public func configure(slider: AppSlideShow.Presentable, segment: AppSegment.Presentable) {
        itemsCount = slider.items.count
        slideShowView.configure(for: slider)
        appSegment.configure(for: segment)
        appSegment.delegate = self
    }
    
    public func hasContent() -> Bool {
        return itemsCount > 0
    }
    
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        containerHightConstraint.constant = scrollView.contentInset.top
        let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top)
        if offsetY <= -400.0 {
            UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [.curveEaseInOut], animations: {
                self.slideShowView.alpha = 0.0
            }, completion: nil)
        } else {
            UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [.curveEaseInOut], animations: {
                self.slideShowView.alpha = 1
            }, completion: nil)
            
        }
        containerView.clipsToBounds = offsetY <= 0
        let segmentHeight = segmentHeightConstraint.constant - 20
        slideShowBottomConstraint.constant = offsetY >= 0 ? -segmentHeight : (-offsetY / 2) - segmentHeight
        slideShowHeightConstraint.constant = max(offsetY + scrollView.contentInset.top, scrollView.contentInset.top)
    }
}
