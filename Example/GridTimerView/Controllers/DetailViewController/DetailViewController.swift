//
//  DetailViewController.swift
//  GridTimerView_Example
//
//  Created by Alberto Aznar de los Ríos on 7/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    var source: DetailViewSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = source?.title
        subtitleLabel.text = source?.subtitle
    }
}
