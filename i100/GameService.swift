//
//  GameService.swift
//  i100
//
//  Created by Alessio Roberto on 03/09/16.
//  Copyright © 2016 Alessio Roberto. All rights reserved.
//

import Foundation

public final class GameService {
    var chessboard: ChessBoard
    
    init(chessboard: ChessBoard) {
        self.chessboard = chessboard
    }
    
    let userScoreKey = "com.alessioroberto.i100.userScore"
    let userMatrixKey = "com.alessioroberto.i100.userMatrix"
    
    var gameScore = 0
    
    public static var shared: GameService!
}

extension GameService {
    //MARK: Storage
    public func userScore() -> Int {
        return UserDefaults.standard.integer(forKey: userScoreKey)
    }
    
    public func update(score: Int) {
        UserDefaults.standard.set(score, forKey: userScoreKey)
    }
    
    public func userMatrix() -> ChessBoardType? {
        guard let obj = UserDefaults.standard.dictionary(forKey: userMatrixKey) else {
            return nil
        }
        var tmp:ChessBoardType = [:]
        for (key, value) in obj {
            tmp[Int(key)!] = CellType(rawValue: value as! Int)
        }
        return tmp
    }
    
    public func update(matrix: ChessBoardType) {
        var tmp: [String: Int] = [:]
        for (key, value) in matrix {
            tmp["\(key)"] = value.rawValue
        }
        let obj = tmp as AnyObject
        UserDefaults.standard.set(obj, forKey: userMatrixKey)
    }
    
    public func resetData() {
        UserDefaults.standard.set(0, forKey: userScoreKey)
        UserDefaults.standard.set(nil, forKey: userMatrixKey)
        chessboard.resetMatrix()
        gameScore = 0
    }
    
    //MARK: game play
    public func evaluete(move cell: Int) -> Int {
        if (self.chessboard.user(play: cell)) {
            gameScore += 1
            return gameScore
        } else {
            return -1
        }
    }
    
    public func getGameScore() -> Int {
        return gameScore
    }
}
