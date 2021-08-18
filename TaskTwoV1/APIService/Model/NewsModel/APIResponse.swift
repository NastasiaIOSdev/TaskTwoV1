//
//  APIResponse.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 18.08.2021.
//

import Foundation

struct APIResponse2: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?

}

struct Source: Codable {
    let name: String
}
