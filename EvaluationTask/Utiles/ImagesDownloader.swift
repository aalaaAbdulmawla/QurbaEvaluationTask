//
//  ImagesDownloader.swift
//  EvaluationTask
//
//  Created by Alaa Abdulmawla on 8/27/18.
//  Copyright © 2018 Alaa Abdulmawla. All rights reserved.
//

import Foundation

import UIKit
import AlamofireImage

extension UIImageView {
    func alomofireDownloadImageWithProgress(_ url: URL) {
        _ = self.configureLoadingIndicator()
        af_setImage(withURL: url, progress: { progress in
            if progress.fractionCompleted >= 1 {
                self.stopLoadingAnimation()
            }
        })
        
        if let _ = image   { self.stopLoadingAnimation() }
    }
    
    func stopLoadingAnimation() {
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
    }
    
    fileprivate func configureLoadingIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        activityIndicator.center = CGPoint(x: self.bounds.midX , y: self.bounds.midY)
        self.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        return activityIndicator
    }
    
}
