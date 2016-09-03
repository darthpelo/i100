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

struct ChessBoard {
    let maxCell = 99
    
    private var matrix:[Int: CellType] = {
        var tmp:[Int: CellType] = [:]
        for i in 0..<100 {
            tmp[i] = .Empty
        }
        return tmp
    }()
    
    var lastCell:Int?
    
    func value(at cell: Int) -> CellType {
        if cell < 0 || cell > maxCell {
            return .Out
        }
        return matrix[cell]!
    }
}
