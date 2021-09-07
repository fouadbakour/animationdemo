//
//  ButtonStyles.swift
//  UIComponents
//
//  Created by Fouad Bakour on 05/09/2021.
//

import Foundation
import UIKit

public struct ButtonStyles {
    public var textColor: UIColor
    public var font: UIFont
    public var backgroundColor: UIColor
    public var borderColor: UIColor
    public var cornerRadius: CGFloat
    public var isCircular: Bool
}

extension ButtonStyles {
    public static var primary: ButtonStyles {
        .init(textColor: .white,
              font: UIFont.systemFont(ofSize: 15, weight: .semibold),
              backgroundColor: .black,
              borderColor: .clear,
              cornerRadius: 0,
              isCircular: true)
    }
    public static var primaryHighlighted: ButtonStyles {
        .init(textColor: .white,
              font: UIFont.systemFont(ofSize: 15, weight: .semibold),
              backgroundColor: #colorLiteral(red: 0.3450980392, green: 0.7098039216, blue: 0.2784313725, alpha: 1),
              borderColor: .clear,
              cornerRadius: 0,
              isCircular: true)
    }
}

