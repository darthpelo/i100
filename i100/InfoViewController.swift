//
//  InfoViewController.swift
//  i100
//
//  Created by Alessio Roberto on 26/09/16.
//  Copyright © 2016 Alessio Roberto. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    @IBOutlet fileprivate weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text =  InfoViewModel().titleLabel
        }
    }
    
    @IBOutlet fileprivate weak var descriptionTextView: UITextView!
    
    @IBOutlet fileprivate weak var closeButton: UIButton! {
        didSet {
            closeButton.setTitle(NSLocalizedString("X", comment: ""), for: .normal)
            closeButton.accessibilityLabel = NSLocalizedString("access.closebutton", comment: "")
            closeButton.accessibilityIdentifier = "close"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside) 
    }
    
    func closeButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}
