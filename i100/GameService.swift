//
//  GameService.swift
//  i100
//
//  Created by Alessio Roberto on 03/09/16.
//  Copyright © 2016 Alessio Roberto. All rights reserved.
//

import Foundation


/// This class manages the game play and the save/load functions
/// into the local storage
public final class GameService {
    var chessboard: ChessBoard
    
    init(chessboard: ChessBoard) {
        self.chessboard = chessboard
    }
    
    fileprivate let userScoreKey = "com.alessioroberto.i100.userScore"
    fileprivate let userMatrixKey = "com.alessioroberto.i100.userMatrix"
    fileprivate let userMaxScoreKey = "com.alessioroberto.i100.userMaxScore"
    
    fileprivate var gameScore = 0
    
    public static var shared: GameService!
}

extension GameService {
    //MARK: Storage
    
    /// Load from local storage the last user score
    ///
    /// - returns: The user score as Int
    public func userScore() -> Int {
        return UserDefaults.standard.integer(forKey: userScoreKey)
    }
    
    
    /// Upload the user score value into the local storage
    ///
    /// - parameter score: The user score as Int
    public func update(score: Int) {
        UserDefaults.standard.set(score, forKey: userScoreKey)
    }
    
    
    /// Load from local storage the last saved status of the matrix
    ///
    /// - returns: The matrix instance
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
    
    
    /// Update to local storege the last status of the chessboard
    ///
    /// - parameter matrix: The matrix instance to save
    public func update(matrix: ChessBoardType) {
        var tmp: [String: Int] = [:]
        for (key, value) in matrix {
            tmp["\(key)"] = value.rawValue
        }
        let obj = tmp as AnyObject
        UserDefaults.standard.set(obj, forKey: userMatrixKey)
    }
    
    
    /// Reset the game and the last values saved on the local storage
    public func resetData() {
        UserDefaults.standard.set(0, forKey: userScoreKey)
        UserDefaults.standard.set(nil, forKey: userMatrixKey)
        chessboard.resetMatrix()
        gameScore = 0
    }
    
    //MARK: game play
    
    /// Evaluates the user move. If the move is valid, return the new score. -1 otherwhise
    ///
    /// - parameter cell: The cell that corrisponds to the next move
    ///
    /// - returns: The new score after a valid move, -1 otherwhise
    public func evaluete(move cell: Int) -> Int {
        if (self.chessboard.user(play: cell)) {
            gameScore += 1
            // Compare with the MaxUserScore
            if gameScore > UserDefaults.standard.integer(forKey: userMaxScoreKey) {
                UserDefaults.standard.set(gameScore, forKey: userMaxScoreKey)
            }
            return gameScore
        } else {
            return -1
        }
    }
    
    
    /// Returns the max score of the user
    ///
    /// - returns: The max score of the user
    public func getMaxGameScore() -> Int {
        return UserDefaults.standard.integer(forKey: userMaxScoreKey)
    }
    
    
    /// Returns the actual game score of the user
    ///
    /// - returns: The score of the user
    public func getGameScore() -> Int {
        return gameScore
    }
}
