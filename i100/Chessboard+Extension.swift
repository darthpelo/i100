//
//  Chessboard+Extension.swift
//  i100
//
//  Created by Alessio Roberto on 03/09/16.
//  Copyright © 2016 Alessio Roberto. All rights reserved.
//

import Foundation
import UIKit
import Crashlytics

enum NotificationName: String {
    case GameOver
    case Victory
}

extension ChessBoardViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func scoreLabel(with text: String) {
        buttonView.scoreLabel(text:text)
    }
    
    fileprivate func shareScore(score: String?) {
        self.present(share(number: (score != nil) ? score! : String(presenter.actualMaxScore())),
                     animated: true,
                     completion: { [weak self] in
                        self!.anImportantUserAction(name: "SahreScore")
            }
        )
    }
    
    func anImportantUserAction(name aName: String) {
        
        // TODO: Move this method and customize the name and parameters to track your key metrics
        //       Use your own string attributes to track common values over time
        //       Use your own number attributes to track median value over time
        Answers.logCustomEvent(withName: aName)
    }
    
    func victoryAction() {
        Answers.logLevelEnd("Level1",
                            score: presenter.actualMaxScore() as NSNumber?,
                            success: true,
                            customAttributes: [:])
    }
}

//MARK: - ViewProtocol
extension ChessBoardViewController: ViewProtocol {
    func updateChess(at indexPath: IndexPath, with newValue: Int) {
        if let cell = chessboardCollectionView.cellForItem(at: indexPath) as? ChessBoardCollectionViewCell {
            cell.setLabel(value: newValue)
            cell.switchBackground(from: .black, to: .white)
            if let previousCell = presenter.previousCellRow(),
                let previous = chessboardCollectionView.cellForItem(at: IndexPath(row: previousCell, section: 0)) as? ChessBoardCollectionViewCell {
                previous.switchBackground(from: .white, to: .black)
            }
        }
        scoreLabel(with: String(presenter.recordScore()))
        anImportantUserAction(name: "Move")
        presenter.saveGame()
    }
}
//MARK: - Notification
extension ChessBoardViewController: Notification {
    func addObserver(name aName: NotificationName) {
        switch aName {
        case .GameOver:
            let nc = NotificationCenter.default
            nc.addObserver(self,
                           selector: #selector(ChessBoardViewController.catchNotification),
                           name: NSNotification.Name(rawValue: aName.rawValue),
                           object: nil)
        case .Victory:
            let nc = NotificationCenter.default
            nc.addObserver(self,
                           selector: #selector(ChessBoardViewController.catchNotification),
                           name: NSNotification.Name(rawValue: aName.rawValue),
                           object: nil)
        }
    }
    
    func catchNotification(notification:NSNotification) {
        if notification.name.rawValue == NotificationName.GameOver.rawValue {
            alertView.isHidden = false
            alertView.alertLabel.text = NSLocalizedString("Game Over", comment: "")
            anImportantUserAction(name: "GameOver")
            shareScore(score: nil)
        } else {
            alertView.isHidden = false
            alertView.alertLabel.text = NSLocalizedString("Victory!!", comment: "")
            anImportantUserAction(name: "Victory")
            victoryAction()
            shareScore(score: nil)
        }
    }
}
//MARK: - BottomViewDelegate
extension ChessBoardViewController: BottomViewDelegate {
    func requestReset() {
        presenter.resetGame()
        chessboardCollectionView.reloadData()
        alertView.isHidden = true
    }
    
    func requestInfo() {
        self.performSegue(withIdentifier: "InfoVC", sender: nil)
    }
    
    func requestShare(score: String?) {
        shareScore(score: score)
    }
}
//MARK: - UICollectionViewDelegate UICollectionViewDataSource UICollectionViewDelegateFlowLayout
extension ChessBoardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Square", for: indexPath) as! ChessBoardCollectionViewCell
        cell.setLabel(value: -1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.height/10,height:  collectionView.frame.size.height/10)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.userDidSelectItemAt(indexPath: indexPath)
    }
}
//MARK: - Sharable
extension ChessBoardViewController: Sharable {
    func share(number: String) -> UIViewController {
        let text = "Ho fatto \(number) giocando ad #i100! Prova a battermi!"
        let url = URL(string: "https://itunes.apple.com/nl/app/i100/id352554795")
        let activityViewController = UIActivityViewController(activityItems: [text, url!], applicationActivities: nil)
        return activityViewController
    }
}
