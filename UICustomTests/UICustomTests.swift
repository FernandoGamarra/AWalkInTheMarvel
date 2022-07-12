//
//  UICustomTests.swift
//  UICustomTests
//
//  Created by Fernando Gamarra on 12/7/22.
//

import XCTest

class UICustomTests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
//        let cellCount = app.tables.cells.count
//        XCTAssertTrue(cellCount > 0)

        let tableCount = app.tables.count
        XCTAssertTrue(tableCount > 0)
        
        let tables = app.tables
        let cellCount = tables.cells.count
        XCTAssertTrue(cellCount > 0)
        
        let firstCell = tables.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.exists)
        firstCell.tap()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func myTest() throws {
        let app = XCUIApplication()
        app.launch()
        
        let cellQuery = self.app.tables.cells.element(boundBy: 2)
        cellQuery.buttons["signup button"].tap()
    }
}
