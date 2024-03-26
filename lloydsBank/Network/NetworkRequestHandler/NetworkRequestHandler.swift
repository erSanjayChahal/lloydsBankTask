//
//  NetworkRequestProtocol.swift
//  lloydsBank
//
//  Created by Sanjay Chahal on 24/03/24.
//

import Foundation
import Combine

final class NetworkRequestHandler: NetworkRequestProtocol {
    
    private let urlSession: URLSessionProtocol
    
    init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }
}

extension NetworkRequestHandler {
    
    func performRequest<Model: Decodable>(apiData: APIDataProtocol) -> AnyPublisher<Model, NetworkError> {
        guard let urlRequest = createURLRequest(from: apiData) else {
            return Fail(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        }
        debugPrint("making api call :- \(String(describing: urlRequest.url?.absoluteString))")
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.invalidResponse
                }
                guard 200..<300 ~= httpResponse.statusCode else {
                    throw NetworkError.requestFailed(statusCode: httpResponse.statusCode)
                }
                return data
            }
            .decode(type: Model.self, decoder: JSONDecoder())
            .mapError { error in
                NetworkError.unableToDecodeResponseData
            }
            .eraseToAnyPublisher()
    }
    
    private func createURLRequest(from apiData: APIDataProtocol) -> URLRequest? {
        
        let urlString = App.Network.baseURL + apiData.relativeURL
        guard let url = URL(string: urlString) else { return nil }
        
        let requestBuilder = NetworkRequestBuilder(url: url,
                                                   method: apiData.method,
                                                   headerParams: apiData.headers,
                                                   bodyParams: apiData.params,
                                                   parameterEncoding: apiData.parameterEncoding)
        return requestBuilder.build()
    }
}
