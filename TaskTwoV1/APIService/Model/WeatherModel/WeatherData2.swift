//
//  WeatherData2.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 24.08.2021.
//

import Foundation

struct WeatherData2: Codable {
    var weather: [Weather2]
    var main: Main
}

struct Weather2: Codable {
    var main: String
}

struct Main: Codable {
    var temp: Double
}
