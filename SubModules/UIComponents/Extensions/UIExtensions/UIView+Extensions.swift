//
//  UIViewExtensions.swift
//  UIComponents
//
//  Created by Fouad Bakour on 05/09/2021.
//

import UIKit

public extension UIView {

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0.0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            guard let borderCgColor = layer.borderColor else { return nil }
            return UIColor(cgColor: borderCgColor)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    func makeCircular() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.cornerRadius = self.frame.size.height / 2
        }
    }
    
    func dropShadow(shadowRadius: CGFloat = 5,
                    shadowColor: UIColor = UIColor.black,
                    shadowOpacity: Float = 0.2,
                    shadowOffset: CGSize = CGSize(width: -1, height: 1)) {
        layer.masksToBounds = false
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowRadius
    }
    
    func removeShadow() {
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowColor = UIColor.clear.cgColor
        self.layer.shadowOpacity = 0
        self.layer.shadowRadius = 0
    }
    
    func layoutAttach(to parentView: UIView, height: CGFloat? = nil, inset: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        parentView.topAnchor.constraint(equalTo: self.topAnchor, constant: inset).isActive = true
        parentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset).isActive = true
        parentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -inset).isActive = true
        parentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset).isActive = true
        
        guard let height = height else { return }
        let heightConstraint = heightAnchor.constraint(greaterThanOrEqualToConstant: height)
        heightConstraint.priority = UILayoutPriority(rawValue: 900)
        heightConstraint.isActive = true
    }
    
    @discardableResult
    func fromNib<T: UIView>(named name: String? = nil) -> T? {
        let bundle = Bundle(for: type(of: self))
        let unwrappedName = name ?? String(describing: type(of: self))
        if Self.nibFileExists(unwrappedName.fileNameForTheme),
           let content = bundle.loadNibNamed(unwrappedName.fileNameForTheme, owner: self, options: nil)?.first as? T {
            return addView(content)
        } else if Self.nibFileExists(unwrappedName),
                  let content = bundle.loadNibNamed(unwrappedName, owner: self, options: nil)?.first as? T {
            return addView(content)
        }
        return nil
    }
    
    private func addView<T: UIView>(_ contentView: T) -> T {
        self.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.layoutAttach(to: self)
        return contentView
    }
    
    /// get nib from bundle
    static var nib: UINib {
        let nibName = nibFileExists(identifier.fileNameForTheme) ? identifier.fileNameForTheme : identifier
        return UINib(nibName: nibName, bundle: Bundle(for: self))
    }
    
    private static func nibFileExists(_ nibName: String) -> Bool {
        Bundle(for: self).path(forResource: nibName, ofType: "nib") != nil
    }
    
    // adding round corners to certain corners
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
      }
}
