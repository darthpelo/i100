//
//  ViewController.swift
//  i100
//
//  Created by Alessio Roberto on 03/09/16.
//  Copyright © 2016 Alessio Roberto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var chessboardCollectionView: UICollectionView!
    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text =  NSLocalizedString("i100", comment: "")
        }
    }
    @IBOutlet weak var buttonView: BottomView! {
        didSet {
            buttonView.delegate = self
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
