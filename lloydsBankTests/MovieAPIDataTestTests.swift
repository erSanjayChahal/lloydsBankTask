import XCTest
@testable import lloydsBank

final class MovieAPIDataTest: XCTestCase {
    
    func testMoviesApiDataPath() {
        let moviesApiData = MoviesApiData()
        XCTAssertEqual(moviesApiData.path, "v3/e0726b55-6d5c-4cac-bbbc-2619c5fff63c", "Incorrect path for MoviesApiData")
    }
    
    func testMoviesApiDataMethod() {
        let moviesApiData = MoviesApiData()
        XCTAssertEqual(moviesApiData.method, .get, "Incorrect method for MoviesApiData")
    }
    
    func testMoviesApiDataParameterEncoding() {
        let moviesApiData = MoviesApiData()
        XCTAssertEqual(moviesApiData.parameterEncoding, .url, "Incorrect parameter encoding for MoviesApiData")
    }
    
    func testMoviesApiDataHeaders() {
        let moviesApiData = MoviesApiData()
        XCTAssertNil(moviesApiData.headers, "Headers should be nil for MoviesApiData")
    }
    
}//
//  MovieAPIDataTest.swift
//  lloydsBankTests
//
//  Created by Sanjay Chahal on 24/03/24.
//

import XCTest
@testable import lloydsBank

final class MovieAPIDataTest: XCTestCase {

    var moviesApiData: MoviesApiData!

    override func setUpWithError() throws {
        try super.setUpWithError()
        moviesApiData = MoviesApiData()
    }

    override func tearDownWithError() throws {
        moviesApiData = nil
        try super.tearDownWithError()
    }

    func testFetchMovies() throws {
        // Given
        let expectation = XCTestExpectation(description: "Fetch movies expectation")

        // When
        moviesApiData.fetchMovies { result in
            // Then
            switch result {
            case .success(let movies):
                XCTAssertFalse(movies.isEmpty, "Movies should not be empty")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Failed to fetch movies with error: \(error)")
            }
        }

        wait(for: [expectation], timeout: 5.0)
    }

    func testFetchMovieDetails() throws {
        // Given
        let movieId = 123
        let expectation = XCTestExpectation(description: "Fetch movie details expectation")

        // When
        moviesApiData.fetchMovieDetails(movieId: movieId) { result in
            // Then
            switch result {
            case .success(let movieDetails):
                XCTAssertNotNil(movieDetails, "Movie details should not be nil")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Failed to fetch movie details with error: \(error)")
            }
        }

        wait(for: [expectation], timeout: 5.0)
    }
}