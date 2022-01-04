//
//  AppSegment.swift
//  UIComponents
//
//  Created by Fouad Bakour on 05/09/2021.
//

import UIKit

// Presentable
public extension AppSegment {
    
    struct Presentable {
        
        public let items: [Items]
        public let selectedId: String
        public init(items: [Items], selectedId: String) {
            self.items = items
            self.selectedId = selectedId
        }
    }
    
    struct Items {
        public let title: String
        public let id: String
        public let defaultStyle: LabelStyles
        public let selectedStyle: LabelStyles
        public init(title: String, id: String, defaultStyle: LabelStyles, selectedStyle: LabelStyles) {
            self.title = title
            self.id = id
            self.defaultStyle = defaultStyle
            self.selectedStyle = selectedStyle
        }
    }
}

// Protocols
public protocol AppSegmentDataSource {
    func configure(for presentable: AppSegment.Presentable)
    func setSelectedId(id: String)
}

public protocol AppSegmentDelegate: AnyObject {
    func didSelectItem(id: String)
}

// Class
public class AppSegment: UIView {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - Private Properties
    private(set) var items: [Items] = []
    private(set) var selectedId: String = "" {
        didSet {
            let index = items.firstIndex(where: { $0.id == selectedId }) ?? 0
            collectionView.reloadData()
            delay(0.1) { [weak self] in
                guard let self = self else { return }
                self.collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .right, animated: true)
            }
        }
    }
    
    // MARK: - public Properties
    public weak var delegate: AppSegmentDelegate?
    
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
        collectionView.registerNib(AppSegmentCollectionViewCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

// MARK: - AppSegment Data Source
extension AppSegment: AppSegmentDataSource {
    public func setSelectedId(id: String) {
        self.selectedId = id
    }
    
    public func configure(for presentable: Presentable) {
        self.items = presentable.items
        self.selectedId = presentable.selectedId
    }
}

// MARK: - UICollectionViewDataSource
extension AppSegment: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = items[indexPath.row]
        let cell = AppSegmentCollectionViewCell.dequeueReusableCell(in: collectionView, indexPath: indexPath)
        cell.label.text = item.title
        cell.label.textAlignment = .center
        cell.label.style = item.id == selectedId ? item.selectedStyle : item.defaultStyle
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension AppSegment: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        selectedId = item.id
        delegate?.didSelectItem(id: selectedId)
    }
}
