//
//  ChessBoardCollectionViewCell.swift
//  i100
//
//  Created by Alessio Roberto on 04/09/16.
//  Copyright © 2016 Alessio Roberto. All rights reserved.
//

import UIKit

class ChessBoardCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var label: UILabel!
    
    func setLabel(text: Int) {
        label.text = "\(text+1)"
    }
}
