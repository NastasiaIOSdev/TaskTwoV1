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

class WeatherDetailViewController: UIViewController {

    // MARK: - Properties

    var locationCoordinates: CLLocationCoordinate2D?
    var locationCity: String = ""
    var locationCountry: String = ""
    var latitude: Double = 0
    var longitude: Double = 0
    var weatherManager = WeatherManager()

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

    // MARK: - Property
    // MARK: - Property

    override func viewDidLoad() {
        super.viewDidLoad()
        weatherView.layer.cornerRadius = 20
    }

}
