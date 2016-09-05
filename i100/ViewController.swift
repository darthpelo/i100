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
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet weak var buttonView: BottomView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUp()
    }
}


extension ViewController: SetUp {
    func setUp() {
        self.setupTitle(text: NSLocalizedString("i100", comment: ""))
        self.buttonView.setUp()
    }
    
    private func setupTitle(text: String) {
        self.titleLabel.text = text
    }
}
