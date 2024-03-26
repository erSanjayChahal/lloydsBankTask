//
//  NetworkRequestBuilder.swift
//  lloyadsBankTest
//
//  Created by Sanjay Chahal on 24/03/24.
//

import Foundation

struct NetworkRequestBuilder {
    let url: URL
    let method: RequestMethod
    let headerParams: [String: String]?
    let bodyParams: [String: Any]?
    let parameterEncoding: ParameterEncoding
    
    func build() -> URLRequest? {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.timeoutInterval = 30
        
        // Set headers if provided
        if let headers = headerParams {
            for (key, value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        // Encode URL parameters if needed
        if parameterEncoding == .url, let bodyData = bodyParams {
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
            urlComponents?.queryItems = bodyData.map { URLQueryItem(name: $0.key, value: String(describing: $0.value)) }
            
            if let encodedURL = urlComponents?.url {
                request.url = encodedURL
            } else {
                return nil
            }
        }
        
        // Encode JSON body if needed
        if parameterEncoding == .json, let bodyData = bodyParams {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: bodyData, options: [])
                request.httpBody = jsonData
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            } catch {
                return nil
            }
        }
        
        return request
    }
}
