//
//  CardViewControllerProtocol.swift
//  EvaluationTask
//
//  Created by Alaa Abdulmawla on 8/27/18.
//  Copyright © 2018 Alaa Abdulmawla. All rights reserved.
//

import Foundation
import UIKit

protocol CardViewControllerProtocol: class {
    func reloadData()
    func getTableView() -> UITableView
    func startActivitityIndicator()
    func stopActitvityIndicator()
}
