//
//  TopViewControllerFinder.swift
//  EvaluationTask
//
//  Created by Alaa Abdulmawla on 8/25/18.
//  Copyright © 2018 Alaa Abdulmawla. All rights reserved.
//

import Foundation

import UIKit

struct TopViewControllerFinder {
    static func getUIApplicationDelegate() -> AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
    
    static func topViewController() -> UIViewController? {
        guard let appDelegate = getUIApplicationDelegate() else { return nil; }
        return self.topViewControllerFromRootViewController(appDelegate.window?.rootViewController)
    }
    
    static func topNavigationController() -> UINavigationController? {
        guard let appDelegate = getUIApplicationDelegate() else { return nil; }
        let viewController = self.topViewControllerFromRootViewController(appDelegate.window?.rootViewController)
        if let navController = viewController as? UINavigationController {
            return navController
        }
        
        return viewController?.navigationController
    }
    
    static func topViewControllerFromRootViewController(_ rootViewController: UIViewController?) -> UIViewController? {
        if let tabBarController = rootViewController as? UITabBarController {
            return self.topViewControllerFromRootViewController(tabBarController.selectedViewController)
        }
        guard let unwrappedViewController = rootViewController?.presentedViewController else { return rootViewController }
        
        if let navController = unwrappedViewController as? UINavigationController {
            guard let unwrappedLastViewcontroller = navController.viewControllers.last else { return unwrappedViewController }
            return self.topViewControllerFromRootViewController(unwrappedLastViewcontroller)
        }
        
        return self.topViewControllerFromRootViewController(unwrappedViewController)
    }
}
