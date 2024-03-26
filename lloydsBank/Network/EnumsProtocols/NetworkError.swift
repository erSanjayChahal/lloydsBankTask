//
//  NetworkError.swift
//  lloyadsBankTest
//
//  Created by Sanjay Chahal on 24/03/24.
//

import Foundation


protocol CustomErrorProtocol: Error {
    var localizedDescription: String { get }
}

enum NetworkError: CustomErrorProtocol {
    case invalidURL
    case invalidResponse
    case requestFailed(statusCode: Int)
    case unableToDecodeResponseData
    case other(description: String)
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid response"
        case .requestFailed(let statusCode):
            return "Request failed with status code: \(statusCode)"
        case .unableToDecodeResponseData:
            return "Unable to decode response data"
        case .other(let description):
            return description
        }
    }
}
