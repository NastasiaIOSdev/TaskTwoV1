//
//  PersonList.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 01.07.2021.
//

import Foundation

struct APIResponse: Codable {
    let results: [Results]
}

struct Results: Codable {
    let name: String
    let gender: String
    let height: String
}
