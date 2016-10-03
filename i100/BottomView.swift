//
//  BottomView.swift
//  i100
//
//  Created by Alessio Roberto on 04/09/16.
//  Copyright © 2016 Alessio Roberto. All rights reserved.
//

import UIKit

protocol BottomViewDelegate: class {
    func requestReset()
    func requestInfo()
}

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
            resetButton.setTitle(NSLocalizedString("Reset", comment: ""), for: .normal)
            resetButton.accessibilityLabel = NSLocalizedString("access.resetbutton", comment: "")
            resetButton.accessibilityIdentifier = "reset"
        }
    }
    @IBOutlet private weak var infoButton: UIButton! {
        didSet {
            infoButton.setTitle(NSLocalizedString("Info", comment: ""), for: .normal)
            infoButton.accessibilityLabel = NSLocalizedString("access.infobutton", comment: "")
            infoButton.accessibilityIdentifier = "info"
        }
    }
    
    weak var delegate:BottomViewDelegate?
    
    func setupView() {
        resetButton.addTarget(self, action: #selector(resetTapped), for: .touchUpInside)
        infoButton.addTarget(self, action: #selector(infoTapped), for: .touchUpInside)
        self.scoreLabel(text: String(GameService.shared.getMaxGameScore()))
    }
    
    //MARK: Public
    func scoreLabel(text: String) {
        scoreLabel.text = text
    }
    
    //MARK: Delegate
    func resetTapped() {
        delegate?.requestReset()
    }
    
    func infoTapped() {
        delegate?.requestInfo()
    }
}

