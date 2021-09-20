//
//  MainWeatherData.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 24.08.2021.
//

import Foundation

struct MainWeatherData: Codable {
    var weather: [MainWeather]
    var main: Main
}

struct MainWeather: Codable {
    var main: String
}

struct Main: Codable {
    var temp: Double
}
