//: Playground - noun: a place where people can play

let rowMove = [0,2,3,2,0,-2,-3,-2]
let columnMove = [3,2,0,-2,-3,-2,0,2]
let maxCounter = 8
var canMove = true
var matrix = (0...99).map{_ in -1}
var maxScore = 0

var score: Int = 0
var lastCell: Int = -1

enum MatrixError: ErrorType {
    case Out
}

private func value(atIndex:Int) throws -> Int {
    if atIndex < 0 || atIndex > 100 {
        throw MatrixError.Out
    } else {
        return matrix[atIndex]
    }
}

func move(at cell: Int) throws {
    var validMove = false
    
    let currentPosition = cell
    let row = (currentPosition/10) + 1;
    let column = currentPosition - ((row - 1) * 10) + 1;
    
    if ((lastCell != -1) && (score != 0)) {
        let lastRow = (lastCell / 10) + 1;
        let lastColumn = lastCell - ((lastRow - 1) * 10) + 1;
        
        var gameOver = false
        
        for i in 0..<maxCounter {
            if ((row == lastRow + rowMove[i]) && (column == lastColumn + columnMove[i])) {
                validMove = true
                break;
            }
        }
        
        if(canMove && validMove && (matrix[currentPosition] == -1)) {
            canMove = false
            
            score += 1
            if score > maxScore { maxScore = score }
            
            lastCell = cell
            
            if (score < 100) {
                for i in 0..<maxCounter {
                    let futureRow = row + rowMove[i];
                    let futureColumn = column + columnMove[i];
                    
                    if((futureRow > 0) && (futureRow < 11) && (futureColumn > 0) && (futureColumn < 11))
                    {
                        let futureCell = futureColumn - 1 + ((futureRow - 1) * 10)
                        
                        do {
                            try value(futureCell)
                        } catch {
                            matrix[futureCell] = -1
                            canMove = true
                        }
                    }
                }
            } else {
                gameOver = true
            }
            
            matrix[lastCell] = score
        } else {
            print("undo")
        }
    } else {
        score += 1
        lastCell = cell
        matrix[lastCell] = score
        
        for i in 0..<maxCounter {
            let futureRow = row + rowMove[i];
            let futureColumn = column + columnMove[i];
            
            if((futureRow > 0) && (futureRow < 11) && (futureColumn > 0) && (futureColumn < 11))
            {
                let futureCell = futureColumn - 1 + ((futureRow - 1) * 10)
                
                do {
                    try value(futureCell)
                } catch {
                    matrix[futureCell] = -1
                    canMove = true
                }
            }
        }
    }
}

do {
    try move(at: 0)
    try move(at: 3)
    try move(at: 6)
    
    print(matrix)
} catch {
    
}

