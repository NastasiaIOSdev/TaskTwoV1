//
//  CatsModel.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 30.06.2021.
//

import Foundation

struct Breed: Codable {
    var idCats: String
    var name: String
    var origin: String
    var description: String
    var image: Image?

    enum CodingKeys: String, CodingKey {
        case idCats = "id"
        case name
        case origin
        case description
        case image
    }
}

struct Image: Codable {
    var url: String?
}
