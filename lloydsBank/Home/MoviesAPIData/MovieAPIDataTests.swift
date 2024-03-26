import XCTest

class MoviesApiDataTests: XCTestCase {
    
    func testMoviesApiDataInitialization() {
        let moviesApiData = MoviesApiData()
        
        XCTAssertEqual(moviesApiData.path, "v3/e0726b55-6d5c-4cac-bbbc-2619c5fff63c", "Incorrect path")
        XCTAssertEqual(moviesApiData.method, .get, "Incorrect method")
        XCTAssertEqual(moviesApiData.parameterEncoding, .url, "Incorrect parameter encoding")
        XCTAssertNil(moviesApiData.headers, "Headers should be nil")
    }
    
    func testMoviesApiDataCustomInitialization() {
        let path = "v3/custom-path"
        let method = HTTPMethod.post
        let parameterEncoding = ParameterEncoding.json
        let headers = ["Authorization": "Bearer token"]
        
        let moviesApiData = MoviesApiData(path: path, method: method, parameterEncoding: parameterEncoding, headers: headers)
        
        XCTAssertEqual(moviesApiData.path, path, "Incorrect path")
        XCTAssertEqual(moviesApiData.method, method, "Incorrect method")
        XCTAssertEqual(moviesApiData.parameterEncoding, parameterEncoding, "Incorrect parameter encoding")
        XCTAssertEqual(moviesApiData.headers, headers, "Incorrect headers")
    }
    
    static var allTests = [
        ("testMoviesApiDataInitialization", testMoviesApiDataInitialization),
        ("testMoviesApiDataCustomInitialization", testMoviesApiDataCustomInitialization)
    ]
}
