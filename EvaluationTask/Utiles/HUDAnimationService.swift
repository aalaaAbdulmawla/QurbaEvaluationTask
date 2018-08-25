//
//  HUDAnimationService.swift
//  EvaluationTask
//
//  Created by Alaa Abdulmawla on 8/25/18.
//  Copyright © 2018 Alaa Abdulmawla. All rights reserved.
//

import Foundation

import UIKit

class HUDAnimationService {
    static let window: UIWindow = {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.backgroundColor = UIColor(white: 0.0, alpha: 0.7)
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        activityIndicator.startAnimating()
        activityIndicator.center = window.center
        window.addSubview(activityIndicator)
        
        return window
    }()
    
    static func showHUDAnimation(_ interactionEnabled: Bool) {
        doOnMainThread {
            window.makeKeyAndVisible()
        }
    }
    
    static func showHudAnimation(_ interactionEnabled: Bool, isVisible: Bool) {
        if !isVisible {return}
        showHUDAnimation(interactionEnabled)
    }
    
    static func hideProgressHUDWith(_ textMessage: String?) {
        doOnMainThread {
            window.isHidden = true
        }
    }
    
    fileprivate static func doOnMainThread(_ closure: @escaping () -> (Void)) {
        DispatchQueue.main.async(execute: closure)
    }
}
