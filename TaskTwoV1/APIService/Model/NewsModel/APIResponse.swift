//
//  APIResponse.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 18.08.2021.
//

import Foundation
import UIKit

struct NewsInfo: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Codable {
    let source: Source?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    var image: UIImage?

    enum CodingKeys: String, CodingKey {
        case source, author, title
        case description
        case url, urlToImage, publishedAt, content
    }
}

struct Source: Codable {
    let idNews: String?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case idNews = "id"
        case name
    }
}

struct SourceFilterResponse: Codable {
    let status: String
    let sources: [SourceFilter]
}

struct SourceFilter: Codable {
    let idNews, name, description: String
    let url: String
    let category: Category
    let language: Language
    let country: String

    enum CodingKeys: String, CodingKey {
        case idNews = "id"
        case name
        case description
        case url, category, language, country
    }
}

enum Category: String, Codable {
    case business
    case entertainment
    case general
    case health
    case science
    case sports
    case technology
}

enum Language: String, Codable {
    case eng = "en"
}
