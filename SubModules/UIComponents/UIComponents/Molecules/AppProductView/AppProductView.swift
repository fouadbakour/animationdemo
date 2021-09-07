//
//  AppProductView.swift
//  UIComponents
//
//  Created by Fouad Bakour on 05/09/2021.
//

import UIKit
// Presentable
public extension AppProductView {
    
    struct Presentable {
        
        public let title: NSMutableAttributedString
        public let description: String
        public let imageUrl: String
        public let ingredients: NSMutableAttributedString
        public let price: String
        public let id: String
        
        public init(title: NSMutableAttributedString,
                    description: String,
                    imageUrl: String,
                    ingredients: NSMutableAttributedString,
                    price: String,
                    id: String) {
            self.title = title
            self.description = description
            self.imageUrl = imageUrl
            self.ingredients = ingredients
            self.price = price
            self.id = id
        }
    }
}

// Protocols
public protocol AppProductViewDataSource {
    func configure(for presentable: AppProductView.Presentable)
}

public protocol AppProductViewDelegate: AnyObject {
    func didTapPriceButton(view: AppProductView, button: AppButton, id: String)
}

// Class
public class AppProductView: UIView {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var titleLabel: AppLabel! {
        didSet {
            titleLabel.style = .productListTitle
        }
    }
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var imageView: AppImageView!
    @IBOutlet private weak var ingredientsLabel: AppLabel!
    @IBOutlet private weak var descriptionLabel: AppLabel! {
        didSet {
            descriptionLabel.style = .productListDesc
        }
    }
    @IBOutlet public weak var priceButton: AppButton! {
        didSet {
            priceButton.style = .primary
        }
    }
    
    // MARK: - Private Properties
    private(set) var id: String?
    
    // MARK: - Public Properties
    public weak var delegate: AppProductViewDelegate?
    
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
        containerView.cornerRadius = 20
        containerView.dropShadow()
        priceButton.addTarget(self, action: #selector(self.priceDidTap), for: .touchUpInside)
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.imageView.roundCorners([.topLeft, .topRight], radius: 20)
        }
    }
    
    @objc func priceDidTap() {
        delegate?.didTapPriceButton(view: self, button: self.priceButton, id: self.id ?? "")
    }
}

// MARK: - AppProductView Data Source
extension AppProductView: AppProductViewDataSource {
    public func configure(for presentable: Presentable) {
        if let url = URL(string: presentable.imageUrl) {
            imageView.url = url
        }
        id = presentable.id
        titleLabel.attributedText = presentable.title
        ingredientsLabel.attributedText = presentable.ingredients
        descriptionLabel.text = presentable.description
        priceButton.setTitle(presentable.price, for: .normal)
        layoutSubviews()
    }
}
