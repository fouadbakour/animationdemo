//
//  AppSlideShow.swift
//  UIComponents
//
//  Created by Fouad Bakour on 05/09/2021.
//

import UIKit

// Presentable
public extension AppSlideShow {
    
    struct Presentable {
        
        public let items: [Items]
        public init(items: [Items]) {
            self.items = items
        }
    }
    
    struct Items {
        public let imageUrl: String
        public init(imageUrl: String) {
            self.imageUrl = imageUrl
        }
    }
}

// Protocols
public protocol AppSlideShowDataSource {
    func configure(for presentable: AppSlideShow.Presentable)
}

// Class
public class AppSlideShow: UIView {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var pageControl: UIPageControl!
    
    // MARK: - Private Properties
    private(set) var items: [Items] = [] {
        didSet {
            pageControl.numberOfPages = items.count
            collectionView.reloadData()
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
        collectionView.registerNib(AppSlideShowCollectionViewCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentMode = .scaleAspectFill
    }
}

// MARK: - AppSlideShow Data Source
extension AppSlideShow: AppSlideShowDataSource {
    public func configure(for presentable: Presentable) {
        self.items = presentable.items
    }
}

// MARK: - UICollectionViewDataSource
extension AppSlideShow: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = items[indexPath.row]
        let cell = AppSlideShowCollectionViewCell.dequeueReusableCell(in: collectionView, indexPath: indexPath)
        if let url = URL(string: item.imageUrl) {
            cell.appImageView.url = url
            cell.appImageView.contentMode = .scaleAspectFill
        }
        cell.contentMode = .scaleAspectFill
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension AppSlideShow: UICollectionViewDelegate {

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width - (scrollView.contentInset.left*2)
        let index = scrollView.contentOffset.x / width
        let roundedIndex = round(index)
        self.pageControl.currentPage = Int(roundedIndex)
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }

    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {

        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}

// MARK: - UICollectionViewDelegate
extension AppSlideShow: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameSize = collectionView.frame.size
        return CGSize(width: frameSize.width, height: self.frame.height)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
}
