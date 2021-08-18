//
//  WeatherManager.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 17.08.2021.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate: class {
    func didUpdateweather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

class WeatherManager {

    let weatherURL = "https://api.openweathermap.org/data/2.5/onecall?appid=ff554f01a90bb15acaa4b59c8e15462e&units=metric"

    weak var delegate: WeatherManagerDelegate?

    func fetchWeather(latitude: Double, longitude: Double) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)&lang=\(Locale.current.languageCode!)&exclude=minutely,hourly,alerts"
        performRequest(with: urlString)
    }

    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                }
                if response == response {
                 }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateweather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }

    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(WeatherData.self, from: weatherData)

            let current = decodeData.current
            var daily: [DailyModel] = []
            var ignoreFirst = true
            for day in decodeData.daily {
                if ignoreFirst {
                    ignoreFirst = false
                } else {
                    let newDay = DailyModel(dailyDt: day.dtDaily ?? 0,
                                            dailyTemp: day.temp?.day ?? 0,
                                            dailyId: day.weather?[0].idWeather ?? 0)
                    daily.append(newDay)
                }
            }
            let currentWeather: CurrentWeather = CurrentWeather(
                curTemperature: current.temp ?? 0,
                curFeelTemp: current.feelLike,
                curHumidity: current.humidity,
                curClouds: current.clouds,
                curWindSpeed: current.windSpeed,
                curWindDeg: current.windDeg,
                curPressure: current.pressure,
                curDescription: current.weather[0].description ?? "",
                curId: current.weather[0].idWeather ?? 0
            )
            let weather = WeatherModel(current: currentWeather, daily: daily)
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
