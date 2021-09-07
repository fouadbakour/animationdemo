//
//  UIResponderExtension.swift
//  UIComponents
//
//  Created by Fouad Bakour on 05/09/2021.
//

import UIKit

public protocol Identifiable {
    static var identifier: String { get }
}

extension UIResponder: Identifiable {
    
    public static var identifier: String { String(describing: self) }
}
