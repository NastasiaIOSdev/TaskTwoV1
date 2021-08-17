//
//  WeatherData.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 17.08.2021.
//

import Foundation

struct WeatherData: Codable {
    let current: Current
    let daily: [Daily]
}

struct Current: Codable {
    let temp: Double
    let feelLike: Double
    let weather: [Weather]
    let humidity: Int
    let pressure: Int
    let clouds: Int
    let windSpeed: Double
    let windDeg: Int
   }

struct Weather: Codable {
    let description: String
    let idWeather: Int
}

struct Daily: Codable {
    let dtDaily: Double
    let temp: Temp
    let weather: [Weather]
}

enum CodingKeys: String, CodingKey {
    case feelLike = "feels_like"
    case windSpeed = "wind_speed"
    case windDeg = "wind_deg"
    case idWeather = "id"
    case dtDaily = "dt"
}
struct Temp: Codable {
    let day: Double
}
