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
    var chessBoard = ChessBoard()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {        
        super.tearDown()
    }
    
    func testchessBoardSetup() {
        let chessBoard = ChessBoard()
        
        XCTAssertNotNil(chessBoard)
        
        let _ = (0..<100).map { (idx) in
            do {
                let value = try chessBoard.value(at: idx)
                XCTAssertEqual(value, .Empty)
            } catch ChessBoardError.Out {
                XCTFail("Out of the chessboard")
            } catch {
                XCTFail()
            }
        }
        
        XCTAssertNil(chessBoard.lastCell)
    }
    
    func testSelectCell() {
        let idx = 0
        do {
            let value = try chessBoard.value(at: idx)
            XCTAssertEqual(value, .Empty)
        } catch ChessBoardError.Out {
            XCTFail("Out of the chessboard")
        } catch {
            XCTFail()
        }
    }
    
    func testSetCell() {
        let idx = 1
        do {
            try chessBoard.setCell(at: idx)
            let value = try chessBoard.value(at: idx)
            XCTAssertEqual(value, .Full)
        } catch ChessBoardError.Out {
            XCTFail("Out of the chessboard")
            
        } catch ChessBoardError.NotEmpty {
            XCTFail("Cell not empty")
        } catch {
            XCTFail()
        }
    }
    
    func testValidMoves() {
        var idx = 1
        
        do {
            let list = try chessBoard.validMoves(at: idx)
            XCTAssertNotNil(list)
            XCTAssertEqual(list.count, 3)
        } catch {
            XCTFail()
        }
        
        idx = 0
        
        do {
            let list = try chessBoard.validMoves(at: idx)
            XCTAssertNotNil(list)
            XCTAssertEqual(list.count, 3)
        } catch {
            XCTFail()
        }
        
        idx = 4
        
        do {
            var list = try chessBoard.validMoves(at: idx)
            XCTAssertNotNil(list)
            XCTAssertEqual(list.count, 5)
            try chessBoard.setCell(at: 1)
            list = try chessBoard.validMoves(at: idx)
            XCTAssertNotNil(list)
            XCTAssertEqual(list.count, 4)
        } catch {
            XCTFail()
        }
        
        idx = 101
        
        do {
            let _ = try chessBoard.validMoves(at: idx)
            XCTFail()
        } catch {
            XCTAssert(true)
        }
        
        idx = 99
        
        do {
            let list = try chessBoard.validMoves(at: idx)
            XCTAssertNotNil(list)
            XCTAssertEqual(list.count, 3)
        } catch {
            XCTFail()
        }
    }
    
    func testUserPlay() {
        var play = 0
        
        XCTAssertTrue(
            chessBoard.user(play: play))
        
        play = 1
        
        XCTAssertFalse(chessBoard.user(play: play))
        
        play = 3
        
        XCTAssertTrue(chessBoard.user(play: play))
    }
}
