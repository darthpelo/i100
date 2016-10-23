//
//  BottomView.swift
//  i100
//
//  Created by Alessio Roberto on 04/09/16.
//  Copyright © 2016 Alessio Roberto. All rights reserved.
//

import UIKit
import Crashlytics

class BottomView: UIView, UIGestureRecognizerDelegate {
    @IBOutlet private weak var scoreLabel: UILabel! {
        didSet {
            scoreLabel.text = "0"
            scoreLabel.accessibilityLabel = NSLocalizedString("access.score", comment: "")
            scoreLabel.accessibilityIdentifier = "score"
            scoreLabel.isUserInteractionEnabled = true
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
        if let score = delegate?.requestMaxScore() {
            self.scoreLabel(text: String(score))
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tap.delegate = self
        scoreLabel.addGestureRecognizer(tap)
    }
    
    //MARK: Public
    func scoreLabel(text: String) {
        scoreLabel.text = text
    }
    
    //MARK: Delegate
    func resetTapped() {
        delegate?.requestReset()
        // TODO: Track the user action that is important for you.
        Answers.logContentView(withName: "Reset", contentType: "Action", contentId: nil)
    }
    
    func infoTapped() {
        delegate?.requestInfo()
        // TODO: Track the user action that is important for you.
        Answers.logContentView(withName: "Info", contentType: "Text", contentId: nil)
    }
    
    func handleTap() {
       delegate?.requestShare(score: scoreLabel.text)
    }
    
}

