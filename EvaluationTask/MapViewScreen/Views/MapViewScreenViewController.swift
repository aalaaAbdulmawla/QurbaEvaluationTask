//
//  MapViewScreenViewController.swift
//  EvaluationTask
//
//  Created by Alaa Abdulmawla on 8/27/18.
//  Copyright © 2018 Alaa Abdulmawla. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewScreenViewController: UIViewController {
    fileprivate var delegate: MapViewScreenPresenterProtocol? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate?.viewDidLoad()
    }
    
    static func instantiateWith(_ delegate: MapViewScreenPresenterProtocol) -> MapViewScreenViewController {
        let storyboard = UIStoryboard(name: "MapViewScreen", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MapViewScreen") as! MapViewScreenViewController
        viewController.delegate = delegate
        
        return viewController
    }

}

extension MapViewScreenViewController: MapViewProtocol {
    func setView(mapView: UIView?) {
        guard let mapView = mapView else { return }
        self.view = mapView
    }
    
    
}
