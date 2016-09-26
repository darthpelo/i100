//
//  ViewController.swift
//  i100
//
//  Created by Alessio Roberto on 03/09/16.
//  Copyright © 2016 Alessio Roberto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet fileprivate weak var chessboardCollectionView: UICollectionView!
    @IBOutlet fileprivate weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text =  NSLocalizedString("i100", comment: "")
        }
    }
    @IBOutlet weak var buttonView: BottomView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        buttonView.delegate = self
        buttonView.setupView()
    }
}

extension ViewController: BottomViewDelegate {
    func requestReset() {
        GameService.shared.resetData()
        chessboardCollectionView.reloadData()
    }
}
