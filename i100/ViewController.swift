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

    @IBOutlet weak var buttonView: BottomView!
    
    @IBOutlet weak var alertView: AlertView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        buttonView.delegate = self
        buttonView.setupView()

        //TODO: clean logic
        self.chessboardCollectionView.reloadData()
        
        addObserver(name: .GameOver)
        addObserver(name: .Victory)
    }
}

extension ViewController: Notifications {
    func addObserver(name aName: NotificationName) {
        switch aName {
        case .GameOver:
            let nc = NotificationCenter.default
            nc.addObserver(self,
                           selector: #selector(ViewController.catchNotification),
                           name: NSNotification.Name(rawValue: aName.rawValue),
                           object: nil)
        case .Victory:
            let nc = NotificationCenter.default
            nc.addObserver(self,
                           selector: #selector(ViewController.catchNotification),
                           name: NSNotification.Name(rawValue: aName.rawValue),
                           object: nil)
        }
    }
    
    func catchNotification(notification:NSNotification) {
        if notification.name.rawValue == NotificationName.GameOver.rawValue {
            alertView.isHidden = false
            alertView.alertLabel.text = NSLocalizedString("Game Over", comment: "")
            anImportantUserAction(name: "GameOver")
            victoryAction()
            self.present(share(number: GameService.shared.getGameScore()), animated: true, completion: { [weak self] in
                self!.anImportantUserAction(name: "SahreScore")
                })
        } else {
            alertView.isHidden = false
            alertView.alertLabel.text = NSLocalizedString("Victory!!", comment: "")
            anImportantUserAction(name: "Victory")
            victoryAction()
            self.present(share(number: GameService.shared.getGameScore()), animated: true, completion: { [weak self] in
                self!.anImportantUserAction(name: "SahreScore")
                })
        }
    }
}

extension ViewController {
    func scoreLabel(with text: String) {
        buttonView.scoreLabel(text:text)
    }
}

extension ViewController: BottomViewDelegate {
    func requestReset() {
        GameService.shared.resetData()
        chessboardCollectionView.reloadData()
        alertView.isHidden = true
    }
    
    func requestInfo() {
        self.performSegue(withIdentifier: "InfoVC", sender: nil)
    }
}
