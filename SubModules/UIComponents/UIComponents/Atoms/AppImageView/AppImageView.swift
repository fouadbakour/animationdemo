//
//  AppImageView.swift
//  UIComponents
//
//  Created by Fouad Bakour on 05/09/2021.
//

import UIKit
import SDWebImage

public protocol AppImageViewDelegate: AnyObject {
    func imageLoadingDidSuccess(result: UIImage)
    func imageLoadingDidFail(error: Error)
    func imageDidTap()
}

public extension AppImageViewDelegate {
    func imageLoadingDidSuccess(result: UIImage) {}
    func imageLoadingDidFail(error: Error) {}
    func imageDidTap() {}
}


public class AppImageView: UIImageView {
    
    // MARK: - Props
    public var delegate: AppImageViewDelegate?
    public var url: URL? {
        didSet {
            loadImageFromURL(url: url)
        }
    }
    
    public var placeholder: UIImage?
    
    // MARK: - Initializers
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
        placeholder = #imageLiteral(resourceName: "placeholder.png")
    }
    
    // MARK: - Common initializer
    func commonInit() {}
    
    // MARK: - Load Image From URL
    public func loadImageFromURL(url: URL?) {
        
        sd_setImage(with: url, placeholderImage: placeholder, options: [.continueInBackground, .queryDiskDataSync, .avoidDecodeImage]) { [weak self] image, error, _, _ in
            guard let self = self else { return }
            if let image = image {
                self.delegate?.imageLoadingDidSuccess(result: image)
            }
            if let error = error {
                self.delegate?.imageLoadingDidFail(error: error)
            }
        }
    }
}
