//
//  NetworkingEnums.swift
//  lloyadsBankTest
//
//  Created by Sanjay Chahal on 24/03/24.
//

import Foundation


enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum ParameterEncoding {
    case url
    case json
}
