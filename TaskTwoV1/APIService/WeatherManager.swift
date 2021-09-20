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

    weak var delegate: WeatherManagerDelegate?

    func fetchWeather(latitude: Double, longitude: Double) {
        var components = URLComponents(string: Constants().onecallWeatherURL)
        components?.queryItems = [
            URLQueryItem(name: "appid", value: Constants().weatherApiAccessKey),
            URLQueryItem(name: "units", value: Constants().degreePaths[degreePath] ?? "metric"),
            URLQueryItem(name: "lat", value: "\(latitude)"),
            URLQueryItem(name: "lon", value: "\(longitude)"),
            URLQueryItem(name: "lang", value: Locale.current.languageCode ?? "en"),
            URLQueryItem(name: "exclude", value: "minutely,hourly,alerts")
        ]
        if let url = components?.url {
            performRequest(with: url)
        }
    }

    func performRequest(with url: URL) {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, _, error) in
            if let error = error {
                self.delegate?.didFailWithError(error: error)
            } else if let data = data,
                      let weather = self.parseJSON(data) {
                self.delegate?.didUpdateweather(self, weather: weather)
            }
        }
        task.resume()
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
                } else if let dailyDt = day.dtDaily,
                          let dailyTemp = day.temp?.day,
                          let dailyId = day.weather?[0].idWeather {
                    let newDay = DailyModel(dailyDt: dailyDt, dailyTemp: dailyTemp, dailyId: dailyId)
                    daily.append(newDay)
                }
            }
            guard let currentTemperature = current.temp,
                  let weatherId = current.weather[0].idWeather else { return nil }
            let currentWeather: CurrentWeather = CurrentWeather(
                curTemperature: currentTemperature,
                curFeelTemp: current.feelLike,
                curHumidity: current.humidity,
                curClouds: current.clouds,
                curWindSpeed: current.windSpeed,
                curWindDeg: current.windDeg,
                curPressure: current.pressure,
                curDescription: current.weather[0].description ?? "",
                curId: weatherId
            )
            let weather = WeatherModel(current: currentWeather, daily: daily)
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }

    func sendRequest(coordinates: CLLocationCoordinate2D, completion: @escaping (MainWeatherData?) -> Void) {
        let decoder = JSONDecoder()

        var components = URLComponents(string: Constants().weatherURL)
        components?.queryItems = [
            URLQueryItem(name: "lat", value: "\(coordinates.latitude)"),
            URLQueryItem(name: "lon", value: "\(coordinates.longitude)"),
            URLQueryItem(name: "units", value: Constants().degreePaths[degreePath] ?? "metric"),
            URLQueryItem(name: "appid", value: Constants().weatherApiAccessKey)
        ]
        guard let url = components?.url else { return }

        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if error == nil, let data = data {
                do {
                    let weather = try decoder.decode(MainWeatherData.self, from: data)
                    completion(weather)
                } catch {
                    completion(nil)
                }
            } else {
                print(error?.localizedDescription ?? "sendRequest error")
                completion(nil)
            }
        }
        task.resume()
    }
}
