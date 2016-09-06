//
//  ChessBoardCollectionViewCell.swift
//  i100
//
//  Created by Alessio Roberto on 04/09/16.
//  Copyright © 2016 Alessio Roberto. All rights reserved.
//

import UIKit

class ChessBoardCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var label: UILabel! {
        didSet {
            label.text = ""
        }
    }
    
    func setLabel(value: Int) {
        if value > 0 { label.text = "\(value)" }
    }
}
