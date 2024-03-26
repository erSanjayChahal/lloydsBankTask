//
//  URLSessionProtocol.swift
//  lloydsBank
//
//  Created by Sanjay Chahal on 24/03/24.
//

import Foundation
import Combine

protocol URLSessionProtocol {
    func dataTaskPublisher(for request: URLRequest) -> URLSession.DataTaskPublisher
}

extension URLSession: URLSessionProtocol {}
