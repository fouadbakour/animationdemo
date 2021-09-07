//
//  Utils.swift
//  UIComponents
//
//  Created by Fouad Bakour on 05/09/2021.
//

import UIKit

public enum APIResult<T> {
    case success(T)
    case failure(String)
}

public typealias GenericClosure<T> = (T) -> Void
public typealias VoidClosure = () -> Void
public typealias GenericResultClosure<T> = GenericClosure<APIResult<T>>


// find top most view controller
public func topController() -> UIViewController? {
    
    // recursive follow
    func follow(_ from: UIViewController?) -> UIViewController? {
        if let to = (from as? UITabBarController)?.selectedViewController {
            return follow(to)
        } else if let to = (from as? UINavigationController)?.visibleViewController {
            return follow(to)
        } else if let to = from?.presentedViewController {
            return follow(to)
        } else {
            return from
        }
    }
    
    // use our own root since when we there is a
    // UIAlertController displaying, it's the
    // keywindow root
    let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow })
    let root = window?.rootViewController
    
    return follow(root)
}

public func random(digits: Int) -> String {
    var number = ""
    for _ in 1...digits {
        number += "\(Int.random(in: 1...9))"
    }
    return number
}

// get status bar height
public func getStatusBarHeight() -> CGFloat {
    var statusBarHeight: CGFloat = 0
    if #available(iOS 13.0, *) {
        let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow})
        statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    } else {
        statusBarHeight = UIApplication.shared.statusBarFrame.height
    }
    return statusBarHeight
}

@discardableResult public func delay(_ delay: Double, _ closure: @escaping VoidClosure) -> VoidClosure? {
    var cancelled = false
    
    DispatchQueue.main.asyncAfter( deadline: DispatchTime.now() + delay) {
        if !cancelled {
            closure()
        }
    }
    
    return {
        cancelled = true
    }
}
