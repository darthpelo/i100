//
//  ChessBoard.swift
//  i100
//
//  Created by Alessio Roberto on 03/09/16.
//  Copyright © 2016 Alessio Roberto. All rights reserved.
//

import Foundation

/// The rappresentation of the Chessboard
public typealias ChessBoardType = [Int:CellType]

/// The cell types
///
/// - Empty:   An empty cell
/// - Full:    A selected cell
/// - Suggest: A suggested cell for the next play
public enum CellType: Int {
    case Empty
    case Full
    case Suggest
}

enum ChessBoardError: Error {
    case Out, NotEmpty, Generic
}

struct ChessBoard {
    let maxCell = 99
    
    private let rowMove = [0,2,3,2,0,-2,-3,-2]
    private let columnMove = [3,2,0,-2,-3,-2,0,2]
    
    private var matrix:ChessBoardType = {
        var tmp:ChessBoardType = [:]
        for i in 0..<100 {
            tmp[i] = .Empty
        }
        return tmp
    }()
    
    /// Last valid cell selected by the player
    var lastCell:Int?
    
    
    /// Returns the CellType of a cell
    ///
    /// - parameter cell: The Int that rapresent the index of a cell in the matrix.
    ///
    /// - throws: Throws ChessBoardError.Out if the index is out of border.
    ///
    /// - returns: The CellType
    func value(at cell: Int) throws -> CellType {
        if cell < 0 || cell > maxCell {
            throw ChessBoardError.Out
        }
        return matrix[cell]!
    }
    
    
    /// Sets as .Full the cell at index if the cell is not .Empty or index out of the borders
    ///
    /// - parameter index: The index of the cell to set .Full
    ///
    /// - throws: The error in cases the index is not correct
    mutating func setCell(at index:Int) throws {
        let value = try self.value(at: index)
        switch value {
        case .Full:
            throw ChessBoardError.NotEmpty
        case .Empty:
            matrix[index] = .Full
        default:
            throw ChessBoardError.Generic
        }
    }
    
    
    /// Returns all the valide moves from a cell.
    ///
    /// - parameter index: The index of the cell.
    ///
    /// - throws: An error if the index is out of the matrix
    ///
    /// - returns: An array of Int with the indexes of all valide moves
    func validMoves(at index: Int) throws -> [Int] {
        if index < 0 || index > maxCell {
            throw ChessBoardError.Out
        }
        
        let currentPosition = index
        let row = (currentPosition/10) + 1;
        let column = currentPosition - ((row - 1) * 10) + 1;
        
        var list: [Int] = []
        for i in 0..<8 {
            let nextRow = row + rowMove[i]
            let nextColumn = column + columnMove[i]
            
            if((nextRow > 0) && (nextRow < 11) &&
                (nextColumn > 0) && (nextColumn < 11)) {
                
                let nextCell = nextColumn - 1 + ((nextRow - 1) * 10)
                if (matrix[nextCell] == .Empty) {
                    list.append(nextCell)
                }
            }
        }
        
        return list
    }
    
    
    /// Return the actual istance of the chessboard
    ///
    /// - returns: The cheesboard
    func getMatrix() -> ChessBoardType {
        return matrix
    }
    
    mutating func resetMatrix() {
        lastCell = nil
        
        let _ = (0..<100).map { matrix[$0] = .Empty }
    }
    
    /// Checks if the user play is valid.
    ///
    /// - parameter cell: The Int that rapresent the index of a cell in the matrix.
    ///
    /// - returns: Return true if the play is valid, false otherwise.
    mutating func user(play cell: Int) -> Bool {
        do {
            if let lastCell = lastCell {
                let play = try validMoves(at: lastCell).filter {$0 == cell}
                if play.count == 1  { return checkPlay(atCell: cell) }
                else                { return false }
            } else {
                return checkPlay(atCell: cell)
            }
        } catch {
            return false
        }
    }
    
    //MARK: Private
    
    private mutating func checkPlay(atCell: Int) -> Bool {
        do {
            try setCell(at: atCell)
            lastCell = atCell
            return true
        } catch {
            return false
        }
    }
}
