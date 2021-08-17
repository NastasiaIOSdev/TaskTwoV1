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
    
    enum CodingKeys: String, CodingKey {
        case current
        case daily
    }
}

struct Current: Codable {
    let temp: Double?
    let feelLike: Double?
    let weather: [Weather]
    let humidity: Int?
    let pressure: Int?
    let clouds: Int?
    let windSpeed: Double?
    let windDeg: Int?

    enum CodingKeys: String, CodingKey {
        case temp, weather, humidity, pressure, clouds
        case feelLike = "feels_like"
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
    }
    init(from decoder: Decoder) {
          let values = try? decoder.container(keyedBy: CodingKeys.self)
        temp = try? values?.decodeIfPresent(Double.self, forKey: .temp)
        feelLike = try? values?.decodeIfPresent(Double.self, forKey: .feelLike)
        humidity = try? values?.decodeIfPresent(Int.self, forKey: .humidity)
        pressure = try? values?.decodeIfPresent(Int.self, forKey: .pressure)
        clouds = try? values?.decodeIfPresent(Int.self, forKey: .clouds)
        windSpeed = try? values?.decodeIfPresent(Double.self, forKey: .windSpeed)
        windDeg = try? values?.decodeIfPresent(Int.self, forKey: .windDeg)
        weather = try? values?.decodeIfPresent([Weather].self, forKey: .weather)
   }
}

struct Weather: Codable {
    let description: String
    let idWeather: Int

    enum CodingKeys2: String, CodingKey {
        case description
        case idWeather = "id"
    }
    init(from decoder: Decoder) {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        description = try? values?.decodeIfPresent(String.self, forKey: .description)
        idWeather = try? values?.decodeIfPresent(Int.self, forKey: .idWeather)
    }
}

struct Daily: Codable {
    let dtDaily: Double
    let temp: Temp
    let weather: [Weather]

    enum CodingKeys3: String, CodingKey {
        case temp, weather
        case dtDaily = "dt"
  }
    init(from decoder: Decoder) {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        dtDaily = try? values?.decodeIfPresent(Double.self, forKey: .dtDaily)
        temp = try? values?.decodeIfPresent(Temp.self, forKey: .temp)
        weather = try? values?.decodeIfPresent([Weather].self, forKey: .temp)
    }
}

struct Temp: Codable {
    let day: Double
}
