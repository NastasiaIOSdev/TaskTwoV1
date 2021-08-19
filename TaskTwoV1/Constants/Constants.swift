//
//  Constants.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 04.07.2021.
//

import Foundation

struct Constants {
    static let breedsURL = URL(string: "https://api.thecatapi.com/v1/breeds")
    static let peopleURL = URL(string: "https://swapi.dev/api/people/")
    static let apiKeyNews = "bd85a9f5eb6c44aa95856a39ed4eeeea"
    static let topHeadlinesURL = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(apiKeyNews)")
    static let searchURLString = "https://newsapi.org/v2/everything?sortedBy=popularity&apiKey=\(apiKeyNews)&q="
}
