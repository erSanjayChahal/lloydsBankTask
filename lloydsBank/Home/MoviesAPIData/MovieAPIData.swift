//
//  MovieAPIData.swift
//  lloydsBank
//
//  Created by Sanjay Chahal on 24/03/24.
//

import Foundation

struct MoviesApiData: APIDataProtocol {
    enum APIVersion: String {
        case v1
        case v2
        case v3
    }
    
    var relativeURL: String
    var method: RequestMethod = .get
    var parameterEncoding: ParameterEncoding = .url
    var headers: [String : String]?
    
    init (_ apiVersion: APIVersion = .v3) {
        self.relativeURL = "erSanjayChahal/isonContainer/movies"
    }
}
