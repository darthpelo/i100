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
        
        GameService.shared = GameService()
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
}
