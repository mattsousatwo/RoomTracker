//
//  RoomTrackerTests.swift
//  RoomTrackerTests
//
//  Created by Matthew Sousa on 3/18/21.
//

import XCTest
@testable import RoomTracker

class RoomTrackerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}


class CoreDataCoderTests: XCTestCase {
    
    let coder = CoreDataCoder()
    
    func testGenID() {
        
        let id = coder.genID()
        let id2 = coder.genID()
        let id3 = coder.genID()
        let id4 = coder.genID()
        print("\nGenID: \(id), \(id2), \(id3), \(id4)\n")
        
        XCTAssertEqual(id.count, 5)
        
        
    }
    
    
    
}
