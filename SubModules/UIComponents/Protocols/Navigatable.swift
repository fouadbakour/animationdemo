//
//  Navigatable.swift
//  UIComponents
//
//  Created by Fouad Bakour on 05/09/2021.
//

import UIKit

public protocol Navigatable {}

extension UIViewController: Navigatable {}

public extension Navigatable where Self: UIViewController {
    
    typealias UpdateHandler = (Self) -> Void
    
    static func push(storyboardName: String, navigationController: UINavigationController? = nil, shouldPreventMultiplePushing: Bool = true, updateHandler: UpdateHandler? = nil) {
        
        // get the view controller to push
        let pushingController = instantiate(from: storyboardName)
        
        // push
        pushingController.push(navigationController: navigationController, shouldPreventMultiplePushing: shouldPreventMultiplePushing, updateHandler: updateHandler)
    }
    
    func push(navigationController: UINavigationController? = nil, shouldPreventMultiplePushing: Bool = true, updateHandler: UpdateHandler? = nil, animated: Bool = true) {
        
        // abort if we dont have a navigation controller
        guard let currentNavigationController = navigationController ?? topController()?.navigationController else { return }
        
        // abort if we are inhibiting multiple pushes and if the top contoller is the controller we are trying to push
        guard !(shouldPreventMultiplePushing && type(of: topController() ?? UIViewController()) == type(of: self)) else { return }
        
        // update the controller to push
        updateHandler?(self)
        
        // push
        currentNavigationController.pushViewController(self, animated: animated)
    }
}
