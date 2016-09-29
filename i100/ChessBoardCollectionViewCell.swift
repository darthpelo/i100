//
//  ChessBoardCollectionViewCell.swift
//  i100
//
//  Created by Alessio Roberto on 04/09/16.
//  Copyright © 2016 Alessio Roberto. All rights reserved.
//

import UIKit

class ChessBoardCollectionViewCell: UICollectionViewCell {
    @IBOutlet fileprivate weak var label: UILabel! {
        didSet {
            label.text = ""
            label.backgroundColor = UIColor.clear
        }
    }
    
    func setLabel(value: Int) {
        if value > 0 {
            label.text = "\(value)"
        } else {
            label.text = ""
            switchBackground(from: UIColor.white, to: UIColor.black)
        }
    }
}

extension ChessBoardCollectionViewCell {
    public func switchBackground(from color: UIColor, to: UIColor) {
        self.backgroundColor = to
        self.label.textColor = color
    }
}
