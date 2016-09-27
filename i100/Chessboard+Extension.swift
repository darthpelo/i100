//
//  Chessboard+Extension.swift
//  i100
//
//  Created by Alessio Roberto on 03/09/16.
//  Copyright © 2016 Alessio Roberto. All rights reserved.
//

import Foundation
import UIKit

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
            scoreLabel(with: String(GameService.shared.getMaxGameScore()))
        }
    }
}

extension ViewController {
    func scoreLabel(with text: String) {
        buttonView.scoreLabel(text:text)
    }
}

