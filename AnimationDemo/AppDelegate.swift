//
//  AppDelegate.swift
//  AnimationDemo
//
//  Created by Fouad Bakour on 04/09/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let viewController = HomeConfigurator.viewController()
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        return true
    }
    
}

