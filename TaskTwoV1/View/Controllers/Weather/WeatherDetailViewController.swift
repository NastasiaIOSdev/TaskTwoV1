//
//  WeatherDetailViewController.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 27.07.2021.
//

import UIKit

class WeatherDetailViewController: UIViewController {

    @IBOutlet weak var cityWeatherLabel: UILabel!
    @IBOutlet weak var weatherView: UIView!
    @IBOutlet weak var weatherPicture: UIImageView!
    @IBOutlet weak var forecastButton: UIButton!

    // MARK: - LifeCycles

    override func viewDidLoad() {
        super.viewDidLoad()
        weatherView.layer.cornerRadius = 20
        forecastButton.layer.cornerRadius = 8
       }
}
