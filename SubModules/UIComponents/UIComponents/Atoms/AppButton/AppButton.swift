//
//  AppButton.swift
//  UIComponents
//
//  Created by Fouad Bakour on 05/09/2021.
//

import UIKit

public class AppButton: UIButton {
    
    // MARK: - Props
    public var style: ButtonStyles? = .primary { didSet {
        updateStyle()
    }}
    
    /// This method/function was designed & implemented to: update the button's style
    private func updateStyle() {
        setTitleColor(style?.textColor, for: .normal)
        backgroundColor = style?.backgroundColor
        titleLabel?.font = style?.font
        if style?.isCircular ?? false {
            makeCircular()
        } else {
            layer.cornerRadius = style?.cornerRadius ?? 0
        }
    }
    
    public func animateDidAddItem(currentStyle: ButtonStyles?, currentText: String) {
        guard let currentStyle = currentStyle else { return }
        isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            self.style = .primaryHighlighted
            self.setTitle("added + 1", for: .normal)
        } completion: { done in
            delay(0.5) { [weak self] in
                guard let self = self else { return }
                UIView.animate(withDuration: 0.3) { [weak self] in
                    guard let self = self else { return }
                    self.style = currentStyle
                    self.setTitle(currentText, for: .normal)
                } completion: { done in
                    self.isUserInteractionEnabled = true
                }
            }
        }
    }
}
