//
//  ChessBoard.swift
//  i100
//
//  Created by Alessio Roberto on 03/09/16.
//  Copyright © 2016 Alessio Roberto. All rights reserved.
//

import Foundation

enum CellType {
    case Empty
    case Full
    case Select
    case Suggest
    case Out
}

enum ChessBoardError: Error {
    case Out, NotEmpty, Generic
}

struct ChessBoard {
    let maxCell = 99
    
    private let rowMove = [0,2,3,2,0,-2,-3,-2]
    private let columnMove = [3,2,0,-2,-3,-2,0,2]
    
    private var matrix:[Int: CellType] = {
        var tmp:[Int: CellType] = [:]
        for i in 0..<100 {
            tmp[i] = .Empty
        }
        return tmp
    }()
    
    var lastCell:Int?
    
    func value(at cell: Int) throws -> CellType {
        if cell < 0 || cell > maxCell {
            throw ChessBoardError.Out
        }
        return matrix[cell]!
    }
    
    mutating func setCell(at index:Int) throws {
        let value = try self.value(at: index)
        switch value {
        case .Out:
            throw ChessBoardError.Out
        case .Full:
            throw ChessBoardError.NotEmpty
        case .Empty:
            matrix[index] = .Full
        default:
            throw ChessBoardError.Generic
        }
    }
    
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
}
