//
//  ViewController.swift
//  EvaluationTask
//
//  Created by Alaa Abdulmawla on 8/23/18.
//  Copyright © 2018 Alaa Abdulmawla. All rights reserved.
//

import UIKit
import CoreLocation

protocol CardViewControllerProtocol: class {
    func reloadData()
    func getTableView() -> UITableView
}

class CardViewController: UIViewController {
    
    @IBOutlet weak var nearbyPlacesTableView: UITableView!  {
        didSet {
            nearbyPlacesTableView.register(UINib.init(nibName: "CardViewCell", bundle: nil),
                forCellReuseIdentifier: "CardViewCell")
        }
    }
    
    var delegate: CardViewPresenterProtocol = CardViewPresenter()
    
    var flag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nearbyPlacesTableView.dataSource = self
        delegate.seViewtDelegate(delegate: self as CardViewControllerProtocol)
        delegate.viewDidLoad()
    }
}

extension CardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return delegate.getCellForRowAtIndex(indexPath)
    }
}

extension CardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate.didSelectRowAtndex(indexPath.row)
    }
}

extension CardViewController: CardViewControllerProtocol {
    func reloadData() {
        nearbyPlacesTableView.reloadData()
    }
    
    func getTableView() -> UITableView {
        return nearbyPlacesTableView
    }
}
