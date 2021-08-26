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
        let url = Constants().weatherURL
        let apikey = Constants().apiAccessKeyWeather
        let units = Constants().degreePaths[degreePath] ?? "units=metric"
        let urlString = "\(url)&appid=\(apikey)&\(units)&lat=\(latitude)&lon=\(longitude)&lang=\(Locale.current.languageCode ?? "en")&exclude=minutely,hourly,alerts"
        performRequest(with: urlString)
    }

    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
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

    func sendRequest(coordinates: CLLocationCoordinate2D, completion: @escaping (WeatherData2?) -> Void) {
        let decoder = JSONDecoder()
        let latitude = coordinates.latitude
        let longitude = coordinates.longitude
        let units = Constants().degreePaths[degreePath] ?? "units=metric"
        let urlString = "\(Constants().weatherURL2)lat=\(latitude)&lon=\(longitude)&\(units)&appid=\(Constants().apiAccessKeyWeather)"
        guard let url = URL(string: urlString) else { return }

        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if error == nil, let data = data {
                do {
                    let weather = try decoder.decode(WeatherData2.self, from: data)
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
