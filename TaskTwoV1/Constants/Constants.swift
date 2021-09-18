//
//  Constants.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 04.07.2021.
//

import Foundation
import MapKit
import UIKit

struct Constants {
    static let breedsURL = URL(string: "https://api.thecatapi.com/v1/breeds")
    static let peopleURL = URL(string: "https://swapi.dev/api/people/")

    let weatherApiAccessKey = "ff554f01a90bb15acaa4b59c8e15462e"
    let onecallWeatherURL =  "https://api.openweathermap.org/data/2.5/onecall"
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather"

    let degreePaths = [
        "celsius": "metric",
        "fahrenheit": "imperial"
    ]

    let degreeSymbols = [
        "celsius": "℃",
        "fahrenheit": "℉"
    ]

    let defaultLocation = CLLocation(latitude: 55.165273, longitude: 61.367668)

}
