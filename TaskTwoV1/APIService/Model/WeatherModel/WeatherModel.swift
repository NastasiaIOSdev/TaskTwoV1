//
//  WeatherModel.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 17.08.2021.
//

import Foundation

struct WeatherModel {
    let current: CurrentWeather
    let daily: [DailyModel]
}

struct CurrentWeather {
    let curTemperature: Double
    let curFeelTemp: Double
    let curHumidity: Int
    let curClouds: Int
    let curWindSpeed: Double
    let curWindDeg: Int
    let curPressure: Int
    let curDescription: String
    let curId: Int
}

struct DailyModel {
    let dailyDt: Double
    let dailyTemp: Double
    let dailyId: Int
}
