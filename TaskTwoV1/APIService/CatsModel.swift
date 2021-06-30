//
//  CatsModel.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 30.06.2021.
//

import Foundation

struct Breed: Codable {
    var name: String
    var origin: String
    var image: Image?
}

struct Image: Codable {
    var url: String?
}
