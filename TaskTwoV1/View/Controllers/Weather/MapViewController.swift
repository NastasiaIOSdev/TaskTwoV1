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

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    // MARK: - Property
    fileprivate let locationManager: CLLocationManager = CLLocationManager()

    // MARK: - IBOutlets

    @IBOutlet weak var mainMap: MKMapView!

    // MARK: - Action

    // MARK: - LifeCycles

    override func viewDidLoad() {
        super.viewDidLoad()
        mainMap.delegate = self
        mainMap.showsUserLocation = true
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
    }

}
