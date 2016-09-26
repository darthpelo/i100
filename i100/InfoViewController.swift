//
//  InfoViewController.swift
//  i100
//
//  Created by Alessio Roberto on 26/09/16.
//  Copyright © 2016 Alessio Roberto. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    @IBOutlet fileprivate weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text =  InfoViewModel().titleLabel
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
