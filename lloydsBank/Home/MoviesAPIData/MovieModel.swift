//
//  MovieModel.swift
//  lloydsBank
//
//  Created by Sanjay Chahal on 24/03/24.
//

import Foundation

struct Movie: Identifiable, Decodable {
    var id: Int
    var title: String
    var subtitle: String
    var description: String
    var imageUrl: String
}
