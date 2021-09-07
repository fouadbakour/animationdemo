//
//  LabelStyles.swift
//  UIComponents
//
//  Created by Fouad Bakour on 05/09/2021.
//

import Foundation
import UIKit

public struct LabelStyles {
    public var textColor: UIColor
    public var font: UIFont
}

extension LabelStyles {
    public static var headerOne: LabelStyles {
        .init(textColor: .black,
              font: UIFont.systemFont(ofSize: 35, weight: .bold))
    }
    public static var headerOneLight: LabelStyles {
        .init(textColor: .lightGray,
              font: UIFont.systemFont(ofSize: 35, weight: .bold))
    }
    public static var headerTwo: LabelStyles {
        .init(textColor: .black,
              font: UIFont.systemFont(ofSize: 25, weight: .bold))
    }
    public static var headerThree: LabelStyles {
        .init(textColor: .black,
              font: UIFont.systemFont(ofSize: 20, weight: .bold))
    }
    
    public static var productListTitle: LabelStyles {
        .init(textColor: .black,
              font: UIFont.systemFont(ofSize: 20, weight: .semibold))
    }
    
    public static var productListDesc: LabelStyles {
        .init(textColor: .darkGray,
              font: UIFont.systemFont(ofSize: 15, weight: .regular))
    }
    
    public static var productListDescHighlighted: LabelStyles {
        .init(textColor: .red,
              font: UIFont.systemFont(ofSize: 15, weight: .regular))
    }
    
    public static var bulletPoint: LabelStyles {
        .init(textColor: .red,
              font: UIFont.systemFont(ofSize: 30, weight: .regular))
    }
    
    public static var badge: LabelStyles {
        .init(textColor: .white,
              font: UIFont.systemFont(ofSize: 10, weight: .regular))
    }
}
