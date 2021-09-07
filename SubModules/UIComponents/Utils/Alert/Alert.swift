//
//  Alert.swift
//  UIComponents
//
//  Created by Fouad Bakour on 05/09/2021.
//

import UIKit

public class AlertBuilder {
    
    private var alertController: UIAlertController
    private var tintColor: UIColor?
    
    public init(title: String? = nil, message: String? = nil, tintColor: UIColor? = nil, preferredStyle: UIAlertController.Style) {
        self.tintColor = tintColor
        alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
    }
    
    public func setPopoverPresentationProperties(sourceView: UIView? = nil,
                                                 sourceRect: CGRect? = nil,
                                                 barButtonItem: UIBarButtonItem? = nil,
                                                 permittedArrowDirections: UIPopoverArrowDirection? = nil) -> Self {
        if let poc = alertController.popoverPresentationController {
            if let view = sourceView {
                poc.sourceView = view
            }
            if let rect = sourceRect {
                poc.sourceRect = rect
            }
            if let item = barButtonItem {
                poc.barButtonItem = item
            }
            if let directions = permittedArrowDirections {
                poc.permittedArrowDirections = directions
            }
        }
        
        return self
    }
    
    @discardableResult
    public func addAction(title: String = "",
                          style: UIAlertAction.Style = .default,
                          handler: (() -> Void)? = { }) -> Self {
        let action = UIAlertAction(title: title, style: style, handler: { _ in handler?() })
        if let tintColor = self.tintColor {
            action.setValue(tintColor, forKey: "titleTextColor")
        }
        alertController.addAction(action)
        return self
    }
    
    public func build() -> UIAlertController {
        return alertController
    }
}

extension UIAlertController {
    public func show(animated: Bool = true, completionHandler: (() -> Void)? = nil) {
        guard let rootVC = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController else {
            return
        }
        var forefrontVC = rootVC
        while let presentedVC = forefrontVC.presentedViewController {
            forefrontVC = presentedVC
        }
        
        if !(forefrontVC is UIAlertController) {
            forefrontVC.present(self, animated: animated, completion: completionHandler)
        }

    }
}
