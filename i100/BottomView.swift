//
//  BottomView.swift
//  i100
//
//  Created by Alessio Roberto on 04/09/16.
//  Copyright © 2016 Alessio Roberto. All rights reserved.
//

import UIKit

class BottomView: UIView {
    @IBOutlet private weak var scoreLabel: UILabel! {
        didSet {
            scoreLabel.text = "0"
            scoreLabel.accessibilityLabel = NSLocalizedString("access.score", comment: "")
            scoreLabel.accessibilityIdentifier = "score"
        }
    }
    @IBOutlet private weak var resetButton: UIButton! {
        didSet {
            self.resetButton.setTitle(NSLocalizedString("Reset", comment: ""), for: .normal)
            self.resetButton.accessibilityLabel = NSLocalizedString("access.resetbutton", comment: "")
            self.resetButton.accessibilityIdentifier = "reset"
        }
    }
    @IBOutlet private weak var infoButton: UIButton! {
        didSet {
            self.infoButton.setTitle(NSLocalizedString("Info", comment: ""), for: .normal)
            self.infoButton.accessibilityLabel = NSLocalizedString("access.infobutton", comment: "")
            self.infoButton.accessibilityIdentifier = "info"
        }
    }
    
    func scoreLabel(text: String) {
        scoreLabel.text = text
    }
}

