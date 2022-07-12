//
//  CustomTests.swift
//  CustomTests
//
//  Created by Fernando Gamarra on 11/7/22.
//

import XCTest
@testable import AWalkInTheMarvel

// SUT -> System Under Test

class CustomTests: XCTestCase {
    
    var sut: ViewModelCharacters!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        try super.setUpWithError()
        sut = ViewModelCharacters()
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        try super.tearDownWithError()
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testGetCharactersd() {
        
        let synchro = expectation(description: "Wait for get characters")
        
        sut.getCharacters() { [self] isCorrect in
            if isCorrect {
                let count = sut.getNumberCharactersLoaded()
                XCTAssertFalse(count > 0, "Invalid result in test")
                XCTAssertTrue(count > 0, "Test OK")
                synchro.fulfill()
            }
            else {
                XCTFail("Error en test")
            }
        }
        
        
        wait(for: [synchro], timeout: 10)
    }
}
