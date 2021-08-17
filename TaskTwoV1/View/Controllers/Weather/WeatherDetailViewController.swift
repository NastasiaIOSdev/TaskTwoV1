//
//  WeatherDetailViewController.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 16.08.2021.
//

import UIKit
import CoreLocation
import MapKit
import Network

class WeatherDetailViewController: UIViewController, WeatherManagerDelegate {

    // MARK: - IBOutlets

    @IBOutlet weak var cityweatherLabel: UILabel!
    @IBOutlet weak var wetherPicture: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelLikeLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var coverCloudsLabel: UILabel!
    @IBOutlet weak var precipitationLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windDirectionLabel: UILabel!
    @IBOutlet weak var presureLabel: UILabel!
    @IBOutlet weak var weatherView: UIView!

    // MARK: - Properties

    var locationCoordinates: CLLocationCoordinate2D?
    var locationCity: String = ""
    var locationCountry: String = ""
    var latitude: Double = 0
    var longitude: Double = 0
    var weatherManager = WeatherManager()
    var dataLoaded = false
    var addToFavorite = true

    // MARK: - lifeCycles

    override func viewDidLoad() {
        super.viewDidLoad()
        weatherView.layer.cornerRadius = 20
        weatherManager.delegate = self
        if let location = self.locationCoordinates {
            weatherManager.fetchWeather(latitude: location.latitude, longitude: location.longitude)

        }
    }

    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.heavyrain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...884:
            return "cloud.bolt"
        default:
            return "cloud.sun"
        }
    }

    var conditionId: Int = 0
    var currentWeather: CurrentWeather? {
        didSet {
            guard let data = currentWeather else {
                return
        }
            temperatureLabel.text = "\(data.curTemperature) °C"
            coverCloudsLabel.text = "\(data.curClouds) %"
            feelLikeLabel.text = "\(data.curFeelTemp) °C"
            humidityLabel.text = "\(data.curHumidity) %"
            presureLabel.text = "\(data.curPressure) hPa"
            windSpeedLabel.text = "\(data.curWindSpeed) meter/sec"
            windDirectionLabel.text = "\(data.curWindDeg)"
            precipitationLabel.text = "\(data.curDescription.capitalized)"
            var image = UIImage(systemName: "")
            if #available(iOS 14, *) {
                image = UIImage(systemName: conditionName)?.withRenderingMode(.alwaysOriginal)
            } else {
                image = UIImage(
                    systemName: conditionName)?.withTintColor(
                        .label,
                        renderingMode:
                        .alwaysOriginal)
            }
            wetherPicture.image = image?.withAlignmentRectInsets(UIEdgeInsets(top: -5, left: -5, bottom: -5, right: -5))
        }
    }

    var daily: [DailyModel] = []

    func didUpdateweather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.currentWeather = weather.current
            self.daily = weather.daily
        }
    }

    func didFailWithError(error: Error) {
        print("Weather did not load: \(error.localizedDescription)")
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Weekly",
        let viewC = segue.destination as? WeekForecastViewController {
            viewC.dailyModels = self.daily
        }
    }

}
