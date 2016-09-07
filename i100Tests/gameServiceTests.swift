//
//  gameServiceTests.swift
//  i100
//
//  Created by Alessio Roberto on 03/09/16.
//  Copyright © 2016 Alessio Roberto. All rights reserved.
//

import XCTest
@testable import i100

class gameServiceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        GameService.shared = GameService(chessboard: ChessBoard())
        GameService.shared.resetData()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGameService() {
        XCTAssertNotNil(GameService.shared)
        
        XCTAssertEqual(GameService.shared.userScore(), 0)
        let score = 34
        GameService.shared.update(score: score)
        XCTAssertEqual(GameService.shared.userScore(), score)
        
        let chessBoard = ChessBoard()
        let matrix = chessBoard.getMatrix()
        GameService.shared.update(matrix: matrix)
        XCTAssertEqual(GameService.shared.userMatrix()!, matrix)
    }
    
    func testGamePlay() {
        let play1 = 1
        let play2 = 4
        
        XCTAssertEqual(GameService.shared.evaluete(move: play1), 1)
        XCTAssertEqual(GameService.shared.evaluete(move: play1), -1)
        XCTAssertEqual(GameService.shared.evaluete(move: play2), 2)
        
        XCTAssertEqual(GameService.shared.getGameScore(), 2)
    }
    
    func testResetGame() {
        let play1 = 1
        let play2 = 4
        
        XCTAssertEqual(GameService.shared.evaluete(move: play1), 1)
        XCTAssertEqual(GameService.shared.evaluete(move: play2), 2)
        
        GameService.shared.resetData()
        
        XCTAssertEqual(GameService.shared.evaluete(move: play1), 1)
        XCTAssertEqual(GameService.shared.evaluete(move: play2), 2)
    }
}
