//
//  Chessboard+Extension.swift
//  i100
//
//  Created by Alessio Roberto on 03/09/16.
//  Copyright © 2016 Alessio Roberto. All rights reserved.
//

import Foundation
import UIKit

enum NotificationName: String {
    case GameOver
}

extension ViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

protocol Notifications {
    func addObserver(name aName: NotificationName)
    
    func catchNotification(notification:NSNotification)
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
        let cell = collectionView.cellForItem(at: indexPath) as! ChessBoardCollectionViewCell
        
        let newValue = GameService.shared.evaluete(move: indexPath.row)
        
        if newValue > 0 {
            cell.setLabel(value: newValue)
            cell.switchBackground(from: UIColor.black, to: UIColor.white)
            if let previousCell = GameService.shared.chessboard.previousCell {
                let previous = collectionView.cellForItem(at: IndexPath(row: previousCell, section: 0)) as! ChessBoardCollectionViewCell
                previous.switchBackground(from: UIColor.white, to: UIColor.black)
            }
            scoreLabel(with: String(GameService.shared.getMaxGameScore()))
        }
    }
}

protocol Sharable {
    func share(number: Int) -> UIViewController
}

extension ViewController: Sharable {
    func share(number: Int) -> UIViewController {
        let text = "Ho fatto \(number) giocando ad i100! Prova a battermi!"
        let url = URL(string: "https://itunes.apple.com/nl/app/i100/id352554795")
        let activityViewController = UIActivityViewController(activityItems: [text, url], applicationActivities: nil)
        return activityViewController
    }
}
