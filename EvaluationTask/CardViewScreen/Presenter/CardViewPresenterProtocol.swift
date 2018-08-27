//
//  CardViewPresenterProtocol.swift
//  EvaluationTask
//
//  Created by Alaa Abdulmawla on 8/27/18.
//  Copyright © 2018 Alaa Abdulmawla. All rights reserved.
//

import Foundation
import UIKit

protocol CardViewPresenterProtocol: class {
    func viewDidLoad()
    func getNumberOfRows() -> Int
    func getCellForRowAtIndex(_ index: IndexPath) -> UITableViewCell
    func didSelectRowAtndex(_ index: Int)
    func seViewtDelegate(delegate: CardViewControllerProtocol)
}

