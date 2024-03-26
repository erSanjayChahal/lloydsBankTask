import XCTest
import Combine
@testable import lloydsBank

final class HomeViewModelTests: XCTestCase {
    
    private var apiManager: MockAPIManager!
    private var viewModel: HomeViewModel!
    private var movieList: [Movie]!
    private var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        apiManager = MockAPIManager()
        viewModel = HomeViewModel(apiManager: apiManager)
        movieList =  JSONLoader().loadJSONOrFail(name: "MovieList")
    }

    override func tearDownWithError() throws {
        apiManager = nil
        viewModel = nil
        movieList = nil
        cancellables.removeAll()
    }
    
    func test_isLoadingTrue_WhenFetchMoviesInProgress() {
        // When
        viewModel.fetchMovies()
        
        // Then
        XCTAssertTrue(viewModel.isLoading)
    }
    
    func test_errorNil_WhenFetchMoviesInProgress() {
        // When
        viewModel.fetchMovies()
        
        // Then
        XCTAssertNil(viewModel.error)
    }
    
    func test_isLoading_False_WhenFetchedMoviesFailed() {
        // Given
        let expectation = XCTestExpectation(description: "Loading should be false when fetching movies failed")
        apiManager.setMockData(Optional<Movie>.none, error: NetworkError.invalidURL)
        
        // When
        viewModel.fetchMovies()
        
        // Then
        assertAfterDelay {
            XCTAssertFalse(self.viewModel.isLoading)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_errorNotNil_WhenFetchedMoviesFailed() {
        // Given
        let expectation = XCTestExpectation(description: "Error should not be nil when fetching movies failed")
        apiManager.setMockData(Optional<Movie>.none, error: NetworkError.invalidURL)
        
        // When
        viewModel.fetchMovies()
        
        // Then
        assertAfterDelay {
            XCTAssertNotNil(self.viewModel.error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }

    
    func test_errorNil_WhenFetchedMoviesSuccess() {
        // Given
        let expectation = XCTestExpectation(description: "Error should be nil when fetching movies successfully")
        apiManager.setMockData(movieList, error: nil)
        
        // When
        viewModel.fetchMovies()
        
        // Then
        assertAfterDelay {
            XCTAssertNil(self.viewModel.error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_fetchMovies_Success() {
        // Given
        let expectation = XCTestExpectation(description: "Movies fetched successfully")
        apiManager.setMockData(movieList, error: nil)
        
        // When
        viewModel.fetchMovies()
        
        // Then
        assertAfterDelay {
            XCTAssertFalse(self.viewModel.isLoading)
            XCTAssertNil(self.viewModel.error)
            XCTAssertEqual(self.viewModel.moviesList.count, 10)
            XCTAssertEqual(self.viewModel.moviesList[0].title, "The Shawshank Redemption")
            XCTAssertEqual(self.viewModel.moviesList[0].id, 1)
            XCTAssertEqual(self.viewModel.moviesList[0].subtitle, "Hope can set you free.")
            XCTAssertEqual(self.viewModel.moviesList[0].imageUrl, "https://image.tmdb.org/t/p/w500/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    // Helper method to assert after a delay
    private func assertAfterDelay(_ assertions: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            assertions()
        }
    }
}
