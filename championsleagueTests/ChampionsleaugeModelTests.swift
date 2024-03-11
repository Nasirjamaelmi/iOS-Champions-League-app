//
//  ChampionsleaugeModelTests.swift
//  championsleagueTests
//
//  Created by Nasir Jama Elmi on 2024-03-11.
//

import XCTest
@testable import championsleague

final class ChampionsleaugeModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    /*func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
        
    }*/
    func testUIColorExtension() {
            // Test your UIColor extension here
            let color = UIColor(red: 255, green: 0, blue: 0)

            // Perform assertions to verify the correctness of the color
        XCTAssertEqual((color.cgColor.components?[0] ?? <#default value#>) * 255, 255, accuracy: 0.001)
        XCTAssertEqual((color.cgColor.components?[1] ?? <#default value#>) * 255, 0, accuracy: 0.001)
        XCTAssertEqual((color.cgColor.components?[2] ?? <#default value#>) * 255, 0, accuracy: 0.001)
        }


}
