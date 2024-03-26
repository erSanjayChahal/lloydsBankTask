//
//  APIDataProtocol.swift
//  lloyadsBankTest
//
//  Created by Sanjay Chahal on 24/03/24.
//

import Foundation

protocol APIDataProtocol {
    var relativeURL: String { get }
    var method: RequestMethod { get }
    var parameterEncoding: ParameterEncoding { get }
    var headers: [String: String] { get }
    var params: [String: Any]? { get }
}

extension APIDataProtocol {
    
    var headers: [String: String] {
        [:]
    }
    
    var params: [String: Any]? {
        nil
    }
    
    var requestType: RequestMethod {
        .get
    }
}
