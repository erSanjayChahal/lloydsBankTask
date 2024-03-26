//
//  MovieAPIDataTest.swift
//  lloydsBankTests
//
//  Created by Sanjay Chahal on 24/03/24.
//

import XCTest
@testable import lloydsBank

final class MovieAPIDataTest: XCTestCase {
    
    var apiData: MoviesApiData!

    override func setUpWithError() throws {
        apiData = MoviesApiData()
    }

    override func tearDownWithError() throws {
        apiData = nil
    }

    func test_APIData_ReturnsExpectedRequestMethod() {
        XCTAssertEqual(self.apiData.method, .get)
    }
    
    func test_APIData_ReturnsExpectedRelativeURL() {
        XCTAssertEqual(self.apiData.relativeURL, "erSanjayChahal/isonContainer/movies")
    }
    
    func test_APIData_ReturnsExpectedHeaders() {
        XCTAssertNil(self.apiData.headers)
    }
    
    func test_APIData_ReturnsExpectedParams() {
        let params = self.apiData.params
        XCTAssertNil(params)
    }
}
