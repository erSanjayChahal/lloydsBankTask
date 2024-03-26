//
//  JSONLoader.swift
//  lloydsBankTests
//
//  Created by Sanjay Chahal on 25/03/24.
//

import Foundation
import UIKit
import XCTest

final class JSONLoader {
    
    init() {}
    
    internal var currentBundle: Bundle = {
        return Bundle(for: JSONLoader.self)
        
    }()
    
    func loadJSONOrFail<T>(name: String,
                           keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
                           dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate) -> T where T: Decodable {
        do {
            return try loadJSON(name: name, keyDecodingStrategy: keyDecodingStrategy, dateDecodingStrategy: dateDecodingStrategy)
        } catch let error {
            XCTFail("\(error)")
            preconditionFailure(error.localizedDescription)
        }
    }
    
    func loadDataOrFail<T>(from object: T) -> Data where T: Codable {
        do {
            return try JSONEncoder().encode(object)
        } catch let error {
            XCTFail("\(error)")
            preconditionFailure(error.localizedDescription)
        }
    }
    
    func loadJSON<T>(name: String,
                     file: StaticString = #file,
                     line: UInt = #line,
                     keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
                     dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate) throws -> T where T: Decodable {
        let data = try loadFile(name: name, ofType: "json", file: file, line: line)
        return try decode(from: data, keyDecodingStrategy: keyDecodingStrategy, dateDecodingStrategy: dateDecodingStrategy)
    }
    
    func decode<T>(from data: Data,
                   keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
                   dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate) throws -> T where T: Decodable {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = keyDecodingStrategy
        jsonDecoder.dateDecodingStrategy = dateDecodingStrategy
        return try jsonDecoder.decode(T.self, from: data)
    }
    
    func encode<T>(from object: T) throws -> Data where T: Encodable {
        return try JSONEncoder().encode(object)
    }
    
    func loadFile(name: String,
                  ofType type: String,
                  file: StaticString = #file,
                  line: UInt = #line) throws -> Data {
        let bundle = currentBundle
        
        guard let path = bundle.path(forResource: name, ofType: type),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
                let message: String
                if let bundleIdentifier = bundle.bundleIdentifier {
                    message = "Couldn't load file named \(name).\(type) in bundle \(bundleIdentifier)"
                } else {
                    message = "Couldn't load file named \(name).\(type)"
                }
                
                throw JSONLoaderError.loadJSONFileError(message: message, file: file, line: line)
        }
        return data
    }
    
}

enum JSONLoaderError: Error {
    case loadJSONFileError(message: String, file: StaticString, line: UInt)
}
