//
//  i100UITests.swift
//  i100UITests
//
//  Created by Alessio Roberto on 03/09/16.
//  Copyright © 2016 Alessio Roberto. All rights reserved.
//

import XCTest

class i100UITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        
        XCTAssert(app.buttons["info"].exists)

        XCTAssert(app.buttons["reset"].exists)
        
        XCTAssert(app.staticTexts["score"].exists)
        
        snapshot("0Launch")
        
        app.staticTexts["i100"].tap()
                
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery.children(matching: .cell).element(boundBy: 0).otherElements.children(matching: .staticText).element.tap()
        collectionViewsQuery.children(matching: .cell).element(boundBy: 3).otherElements.children(matching: .staticText).element.tap()
        collectionViewsQuery.children(matching: .cell).element(boundBy: 33).otherElements.children(matching: .staticText).element.tap()
        collectionViewsQuery.children(matching: .cell).element(boundBy: 63).otherElements.children(matching: .staticText).element.tap()
        collectionViewsQuery.children(matching: .cell).element(boundBy: 85).otherElements.children(matching: .staticText).element.tap()
        
        snapshot("1Game")
    }
    
}
