//
//  AppLabel.swift
//  UIComponents
//
//  Created by Fouad Bakour on 05/09/2021.
//

import UIKit

public class AppLabel: UILabel {

    // MARK: - Props
    public var style: LabelStyles? = .headerOne { didSet {
        updateStyle()
    }}
    
    /// This method/function was designed & implemented to: update the label's style
    private func updateStyle() {
        font = style?.font
        textColor = style?.textColor
    }
}
