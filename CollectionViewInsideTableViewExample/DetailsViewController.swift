//
//  DetailsViewController.swift
//  CollectionViewInsideTableViewExample
//
//  Created by John Codeos on 12/30/19.
//  Copyright © 2019 John Codeos. All rights reserved.
//

import Foundation
import UIKit


class DetailsViewController: UIViewController {
    
    var backgroundColor: UIColor!
    var backgroundColorName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = backgroundColor
        self.navigationItem.title = backgroundColorName
    }
}
