//
//  APIManager.swift
//  lloyadsBankTest
//
//  Created by Sanjay Chahal on 24/03/24.
//

import Foundation
import Combine

 

protocol APIManagerProtocol {
     func fetch<T: Decodable>(_ apiData: APIDataProtocol) -> AnyPublisher<T, NetworkError>
}

final class APIManager: APIManagerProtocol {
    
    private let queue: DispatchQueue
    private let requestHandler: NetworkRequestProtocol
    
    init(requestHandler: NetworkRequestProtocol = NetworkRequestHandler(), queue: DispatchQueue =  DispatchQueue(label: "com.lloyadsBankTest.APIManager.queue", attributes: .concurrent)) {
        self.requestHandler = requestHandler
        self.queue = queue
    }
    
    func fetch<T: Decodable>(_ apiData: APIDataProtocol) -> AnyPublisher<T, NetworkError> {
        return requestHandler.performRequest(apiData: apiData)
    }
}
