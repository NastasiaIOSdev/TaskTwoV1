//
//  MapViewController.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 27.07.2021.
//

import UIKit
import MapKit
import Contacts
import CoreLocation

class MapViewController: UIViewController {

    fileprivate let locationManager: CLLocationManager = CLLocationManager()
    var myPosition = CLLocationCoordinate2D()
    let segueIdentifier = "Detail"
    let geocoder = CLGeocoder()

    // MARK: - IBOutlets

    @IBOutlet weak var mainMap: MKMapView!

    // MARK: - lifeCycles

    override func viewDidLoad() {
        super.viewDidLoad()
        mainMap.delegate = self
        mainMap.showsUserLocation = true
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        mainMap.showsUserLocation = true
        startingPin()
    }

    // MARK: - Action

    @IBAction func searchBtn(_ sender: UIBarButtonItem) {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.delegate = self
        present(searchController, animated: true, completion: nil)
        searchController.searchBar.placeholder = "City search..."
        searchController.searchBar.tintColor = UIColor.black
    }

    @IBAction func onChangeTipe(_ sender: UISegmentedControl) {
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

    @IBAction func addPin(_ sender: UILongPressGestureRecognizer) {
        let location = sender.location(in: self.mainMap)
        let locCoord = self.mainMap.convert(location, toCoordinateFrom: self.mainMap)
        let annotation = MKPointAnnotation()
        annotation.coordinate = locCoord
        annotation.title = "Temperature"
        annotation.subtitle = "Location place"

        let allAnnotations = self.mainMap.annotations
        self.mainMap.removeAnnotations(allAnnotations)
        self.mainMap.addAnnotation(annotation)

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func startingPin() {
        let location = CLLocation(latitude: 56.305768, longitude: 44.070186)
        let pin = PinInfo(coordinatePin: CLLocationCoordinate2D(
                            latitude: 56.305768,
                            longitude: 44.070186),
                          description: "Company",
                          titlePin: "Orion Innovation",
                          namePin: "Orion Innovation")
        let region: CLLocationDistance = 850
        func centerMap(location: CLLocation) {
            let coordinate = MKCoordinateRegion(center: location.coordinate,
                                                latitudinalMeters: region, longitudinalMeters: region)
            mainMap.setRegion(coordinate, animated: true)
        }
        centerMap(location: location)
        mainMap.addAnnotation(pin)
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
    }
}

extension MapViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)

        geocoder.geocodeAddressString(searchBar.text!) { (placemarks: [CLPlacemark]?, error: Error?) in

            if error == nil {
                let placemark = placemarks?.first
                let annotation = MKPointAnnotation()
                annotation.coordinate = (placemark?.location?.coordinate)!
                annotation.title = searchBar.text!

                let spam = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                let region = MKCoordinateRegion(center: annotation.coordinate, span: spam)

                self.mainMap.setRegion(region, animated: true)
                self.mainMap.addAnnotation(annotation)
                self.mainMap.selectAnnotation(annotation, animated: true)
            } else {
                print("Error")
            }
        }
    }
}

extension MapViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        let annotationID = "AnnotationID"
        var annotationView: MKAnnotationView?
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationID) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        } else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationID)
            annotationView?.canShowCallout = true
            annotationView?.calloutOffset = CGPoint(x: -4, y: 4)
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        if let annotationView = annotationView {
            annotationView.canShowCallout = true
            annotationView.image = UIImage(named: "img_pin")
        }
        return annotationView
    }

    func mapView(_ mapView: MKMapView,
                 annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        performSegue(withIdentifier: segueIdentifier, sender: nil)
    }
}
