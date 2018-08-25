//
//  ConnectionStatus.swift
//  EvaluationTask
//
//  Created by Alaa Abdulmawla on 8/25/18.
//  Copyright © 2018 Alaa Abdulmawla. All rights reserved.
//

import UIKit

class ConnectionStatus: UIViewController {
     var previosRequest: RequestData? = nil
    @IBOutlet weak var connectionHeaderLabel: UILabel!
    @IBOutlet weak var bodyInfoLabel: UILabel!
    @IBOutlet fileprivate weak var retryButton: UIButton!
    let titleKey = "k_no_connection"
    let bodyKey = "k_connection_info"
    let retryKey = "k_retry"
    
    static func presentController(_ requestData: RequestData) {
        guard let connectionStatusController = instantiate(requestData) else { return }
        TopViewControllerFinder.topViewController()?.present(connectionStatusController, animated: true, completion: nil)
    }
    
    static func instantiate(_ previosRequestData: RequestData) -> ConnectionStatus? {
        let storyboard = UIStoryboard(name: "ConnectionStatus", bundle: nil)
        if  let viewController = storyboard.instantiateViewController(withIdentifier: "ConnectionStatus") as? ConnectionStatus {
            viewController.previosRequest = previosRequestData
            return viewController
        }
        
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        connectionHeaderLabel.text = titleKey
        bodyInfoLabel.text = bodyKey
        retryButton.setTitle(retryKey, for: UIControlState())
    }


    @IBAction func retryRequest(_ sender: AnyObject) {
        guard let requestData = previosRequest else {return}
        self.dismiss(animated: false, completion: {
        requestData.retryRequest()
        })
    }

    @IBAction func close(_ sender: AnyObject) {
        HUDAnimationService.hideProgressHUDWith(nil)
        self.dismiss(animated: false) {
            self.showPreviosLoadedScreen()
        }
    }
    
    fileprivate func showPreviosLoadedScreen() {
        guard let navigation = TopViewControllerFinder.topNavigationController() else { return }
        if navigation.viewControllers.count > 1 {
            navigation.popViewController(animated: false)
            return
        }
    }
}

class RequestData {
    var specs: RequestSpecs?
    var completion: Any 
    var networking: NetworkingInterface?
    
    init(specs: RequestSpecs, completion: Any?, networking: NetworkingInterface) {
        self.specs = specs
        self.completion = completion as Any
        self.networking = networking
    }
    
    init(completionBlock completion: Any) {
        self.completion = completion
    }
    
    func retryRequest() {
        HUDAnimationService.showHUDAnimation(true)
        if let networkCompletion = completion as? NetworkingCompletionBlock {
            networking?.request(specs!, completionBlock: networkCompletion)
        }
    }
}
