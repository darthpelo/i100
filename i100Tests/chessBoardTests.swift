//
//  chessBoardTests.swift
//  i100Tests
//
//  Created by Alessio Roberto on 03/09/16.
//  Copyright © 2016 Alessio Roberto. All rights reserved.
//

import XCTest
@testable import i100

class chessBoardTests: XCTestCase {
    var chessBoard: ChessBoard?
    
    override func setUp() {
        super.setUp()
        
        chessBoard = ChessBoard()
    }
    
    override func tearDown() {
        chessBoard = nil
        
        super.tearDown()
    }
    
    func testchessBoardSetup() {
        let chessBoard = ChessBoard()
        
        XCTAssertNotNil(chessBoard)
        
        let _ = (0..<100).map { (idx) in
            XCTAssert(chessBoard.value(at: idx) == .Empty)
        }
        
        XCTAssertNil(chessBoard.lastCell)
    }
    
    func testSelectCell() {
        XCTAssert(chessBoard?.value(at: 1000) == .Out)
        XCTAssert(chessBoard?.value(at: -1) == .Out)
        XCTAssert(chessBoard?.value(at: 0) == .Empty)
    }
    
    func testSetCell() {
        let idx = 1
        do {
            try chessBoard?.setCell(at: idx)
        } catch ChessBoardError.Out {
            XCTFail("Out of the chessboard")
            
        } catch ChessBoardError.NotEmpty {
            XCTFail("Cell not empty")
        } catch {
            XCTFail()
        }
        
        XCTAssertEqual(chessBoard?.value(at: idx), .Full)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            let _ = ChessBoard()
        }
    }
    
}
