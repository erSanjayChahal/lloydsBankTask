//
//  NetworkRequestProtocol.swift
//  lloydsBank
//
//  Created by Sanjay Chahal on 24/03/24.
//

import Foundation
import Combine

protocol NetworkRequestProtocol {
    func performRequest<Model: Decodable>(apiData: APIDataProtocol) -> AnyPublisher<Model, NetworkError>
}
