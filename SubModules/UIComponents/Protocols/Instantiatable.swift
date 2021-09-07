//
//  Instantiatable.swift
//  UIComponents
//
//  Created by Fouad Bakour on 05/09/2021.
//

import UIKit

public protocol Instantiatable {
    static func instantiate(from storyboardName: String) -> Self
}

extension UIViewController: Instantiatable { }

public extension Instantiatable where Self: UIViewController {

    static func instantiate(from storyboardName: String) -> Self {

        if let themeViewController = viewControllerForStoryboard(storyboardName.fileNameForTheme) as? Self {
            return themeViewController
        }
        if let initialViewController = viewControllerForStoryboard(storyboardName) as? Self {
            return initialViewController
        }
        return Self()
    }
    
    private static func viewControllerForStoryboard(_ storyboardName: String) -> UIViewController? {
        if storyboardFileExists(storyboardName),
           let viewController = UIStoryboard(name: storyboardName,
                                             bundle: nil).instantiateViewController(withIdentifier: Self.identifier) as? Self {
            return viewController
        }
        return nil
    }
    
    private static func storyboardFileExists(_ storyboardName: String) -> Bool {
        Bundle(for: self).path(forResource: storyboardName, ofType: "storyboardc") != nil
    }
}
