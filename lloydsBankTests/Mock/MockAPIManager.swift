//
//  MockAPIManager.swift
//  lloydsBankTests
//
//  Created by Sanjay Chahal on 25/03/24.
//

import Combine
import Foundation
@testable import lloydsBank

public class MockAPIManager: APIManagerProtocol {
    
    private var mockResponse: Any?
    private var mockError: NetworkError?
    
    public func setMockData<T: Decodable>(_ response: T?, error: NetworkError?) {
        self.mockResponse = response
        self.mockError = error
    }
    
    public func fetch<T: Decodable>(_ apiData: APIDataProtocol) -> AnyPublisher<T, NetworkError> {
        return Future<T, NetworkError> { promise in
                if let error = self.mockError {
                    promise(.failure(error))
                } else {
                    if let response = self.mockResponse as? T {
                        promise(.success(response))
                    } else {
                        promise(.failure(NetworkError.other(description: "unknown")))
                    }
                }
        }
        .eraseToAnyPublisher()
    }
}
