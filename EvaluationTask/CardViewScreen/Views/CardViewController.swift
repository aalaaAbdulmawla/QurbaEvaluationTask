//
//  ViewController.swift
//  EvaluationTask
//
//  Created by Alaa Abdulmawla on 8/23/18.
//  Copyright © 2018 Alaa Abdulmawla. All rights reserved.
//

import UIKit
import CoreLocation

class CardViewController: UIViewController {
    fileprivate var delegate: CardViewPresenterProtocol?
    fileprivate var cellName =  "CardViewCell"
    
    @IBOutlet weak var activitiyIndicator: UIActivityIndicatorView!
    @IBOutlet weak var nearbyPlacesTableView: UITableView!  {
        didSet {
            nearbyPlacesTableView.register(UINib.init(nibName: cellName, bundle: nil),
                forCellReuseIdentifier: cellName)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nearbyPlacesTableView.dataSource = self
        activitiyIndicator?.hidesWhenStopped = true
        delegate = CardViewPresenter(view: self)
        delegate?.viewDidLoad()
    }
}

extension CardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate?.getNumberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return delegate?.getCellForRowAtIndex(indexPath) ?? UITableViewCell()
    }
}

extension CardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didSelectRowAtndex(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: CGRect.zero)
    }
}

extension CardViewController: CardViewControllerProtocol {
    func startActivitityIndicator() {
        activitiyIndicator?.startAnimating()
    }
    
    func stopActitvityIndicator() {
        activitiyIndicator?.stopAnimating()
    }
    
    func reloadData() {
        nearbyPlacesTableView.reloadData()
    }
    
    func getTableView() -> UITableView {
        return nearbyPlacesTableView
    }
}
