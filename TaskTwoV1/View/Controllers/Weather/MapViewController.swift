//
//  MapViewController.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 16.08.2021.
//

import UIKit
import MapKit
import Contacts
import CoreLocation
import Network
import SideMenu

class MapViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet weak var mainMap: MKMapView!
    @IBOutlet weak var searchresultsTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    // MARK: - Property

    var searchCompleter = MKLocalSearchCompleter()
    var searchResults = [MKLocalSearchCompletion]()
    fileprivate let locationManager: CLLocationManager = CLLocationManager()
    var myPosition = CLLocationCoordinate2D()
    var locationCoordinates: CLLocationCoordinate2D?
    var geocoder = CLGeocoder()
    var weatherManager = WeatherManager()
    let zoomLevelDelta = 0.05
    var latitude: Double = 0
    var longitude: Double = 0
    var ignoresearchResults = true
    let region: CLLocationDistance = 2000

    func setSearchresults(_ results: [MKLocalSearchCompletion]) {
        searchResults = results
        let hidden = results.count == 0
        self.searchresultsTableView.isHidden = hidden
    }

    // MARK: - LifeCycles

    override func viewDidLoad() {
        super.viewDidLoad()
        mainMap.delegate = self
        mainMap.showsUserLocation = true
        searchCompleter.delegate = self
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        startingPin()
        if let location = self.locationCoordinates {
            weatherManager.fetchWeather(latitude: location.latitude, longitude: location.longitude)
            let recognizer = UITapGestureRecognizer(target: self, action: #selector(addPin(sender:)))
            mainMap.addGestureRecognizer(recognizer)
        }
    }

    // MARK: - Action

    @IBAction func didTapMenuButton() {
        if let viewController = (UIApplication.shared.windows.first?.rootViewController as? TabBarViewController) {
            viewController.presentMenu()
        }
    }

    @IBAction func onChangeType(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            mainMap.mapType = MKMapType.standard
        case 1:
            mainMap.mapType = MKMapType.satellite
        case 2:
            mainMap.mapType = MKMapType.hybrid
        default:
            break
        }
    }

    @IBAction func addPin(sender: UITapGestureRecognizer) {

        let touchLocation = sender.location(in: mainMap)
        let locCoord = mainMap.convert(touchLocation, toCoordinateFrom: mainMap)

        print("Tapped at:\nlat: \(locCoord.latitude)\nlong: \(locCoord.longitude)")

        weatherManager.sendRequest(coordinates: locCoord) { weather in
            DispatchQueue.main.async {
                let simbol = Constants().degreeSymbols[degreePath] ?? "℃"
                let annotation = MKPointAnnotation()
                annotation.coordinate = locCoord
                if let weather = weather {
                    annotation.title = "\(weather.main.temp) \(simbol)"
                } else {
                    annotation.title = "error data"
                }
                let allAnnotation = self.mainMap.annotations
                self.mainMap.removeAnnotations(allAnnotation)
                self.mainMap.addAnnotation(annotation)
                //  self.mainMap.selectAnnotation(annotation, animated: true)
            }
        }
    }

    func centerMap(location: CLLocation) {
        let coordinate = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: region, longitudinalMeters: region)
        mainMap.setRegion(coordinate, animated: true)
    }

    func startingPin() {
        let location = Constants().defaultLocation
        let pin = PinInfo(coordinatePin: location.coordinate,
                          description: "Place",
                          titlePin: "Gagarin Park",
                          namePin: "Place")
        centerMap(location: location)
        mainMap.addAnnotation(pin)
    }

    func hightLightedText(_ text: String, inRanges ranges: [NSValue], size: CGFloat) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: text)
        let regular = UIFont.systemFont(ofSize: size)
        attributedText.addAttribute(NSAttributedString.Key.font, value: regular, range: NSRange(location: 0, length: text.count))

        let bold = UIFont.boldSystemFont(ofSize: size)
        for value in ranges {
            attributedText.addAttribute(NSAttributedString.Key.font, value: bold, range: value.rangeValue)
        }
        return attributedText
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
