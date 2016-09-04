//
//  BottomView.swift
//  i100
//
//  Created by Alessio Roberto on 04/09/16.
//  Copyright © 2016 Alessio Roberto. All rights reserved.
//

import UIKit

public protocol SetUp {
    func setUp()
}

class BottomView: UIView, SetUp {
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var resetButton: UIButton!
    @IBOutlet private weak var infoButton: UIButton!
    
    func setUp() {
        self.resetButton.setTitle(NSLocalizedString("Reset", comment: ""), for: .normal)
        self.infoButton.setTitle(NSLocalizedString("Info", comment: ""), for: .normal)
        self.infoButton.accessibilityLabel = "Info Button"
        self.infoButton.accessibilityIdentifier = "info"
        self.scoreLabel.text = "0"
    }
}

