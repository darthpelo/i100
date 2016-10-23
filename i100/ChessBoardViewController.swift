//
//  ChessBoardViewController.swift
//  i100
//
//  Created by Alessio Roberto on 03/09/16.
//  Copyright © 2016 Alessio Roberto. All rights reserved.
//

import UIKit

class ChessBoardViewController: UIViewController {

    @IBOutlet weak var chessboardCollectionView: UICollectionView!

    @IBOutlet weak var buttonView: BottomView!
    
    @IBOutlet weak var alertView: AlertView!
    
    lazy var presenter: Presenter = Presenter(view: self)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonView.delegate = self
        buttonView.setupView()
        
        //TODO: clean logic
        self.chessboardCollectionView.reloadData()
        
        addObserver(name: .GameOver)
        addObserver(name: .Victory)
    }
}

struct Presenter {
    weak var view: ViewProtocol?
    
    func actualMaxScore() -> Int {
        return GameService.shared.getGameScore()
    }
    
    func recordScore() -> Int {
        return GameService.shared.getMaxGameScore()
    }
    
    func resetGame() {
        GameService.shared.resetData()
    }
    
    func saveGame() {
        GameService.shared.saveMatrix()
    }
    
    func previousCellRow() -> Int? {
        return GameService.shared.chessboard.previousCell
    }
    
    func userDidSelectItemAt(indexPath: IndexPath) {
        let newValue = GameService.shared.evaluete(move: indexPath.row)
        
        if isValid(newValue) {
            self.view?.updateChess(at: indexPath, with: newValue)
        }
    }
    
    private func isValid(_ value: Int) -> Bool {
        return value > 0
    }
}


