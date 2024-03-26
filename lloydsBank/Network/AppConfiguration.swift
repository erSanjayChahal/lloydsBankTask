//
//  AppConfiguration.swift
//  lloydsBankTest
//
//  Created by Sanjay Chahal on 21/03/24.
//

import Foundation

struct App {
    struct Network {
        static var baseURL: String {
            #if DEBUG
            return "https://my-json-server.typicode.com/"
            #else
            return "https://my-json-server.typicode.com/"
            #endif
        }
    }
}
