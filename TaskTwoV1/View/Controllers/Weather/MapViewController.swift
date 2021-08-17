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

class MapViewController: UIViewController {

    // MARK: - Property
    fileprivate let locationManager: CLLocationManager = CLLocationManager()
    var myPosition = CLLocationCoordinate2D()
    let segueIdentifier = "Detail"
    var geocoder = CLGeocoder()
    
    // MARK: - IBOutlets

    @IBOutlet weak var mainMap: MKMapView!

    // MARK: - LifeCycles

    override func viewDidLoad() {
        super.viewDidLoad()
        startingPin()
        mainMap.delegate = self
        mainMap.showsUserLocation = true
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
    }
    
    // MARK: - Action

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
    
    @IBAction func searchBtn(_ sender: UIBarButtonItem) {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.delegate = self
        present(searchController, animated: true, completion: nil)
        searchController.searchBar.placeholder = "City search..."
        searchController.searchBar.tintColor = UIColor.black
    }
    
    
    func startingPin() {
        let location = CLLocation(latitude: 55.165273, longitude: 61.367668)
        let pin = PinInfo(coordinatePin: CLLocationCoordinate2D(
                            latitude: 55.165273,
                            longitude: 61.367668),
                            description: "Place",
                            titlePin: "Gagarin Park",
                            namePin: "Place")
        let region: CLLocationDistance = 2000
        func centerMap(location: CLLocation) {
            let coordinate = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: region, longitudinalMeters: region)
            mainMap.setRegion(coordinate, animated: true)
        }
        centerMap(location: location)
        mainMap.addAnnotation(pin)
    }

}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        let annotationId = "AnnotationId"
        var annotationView: MKAnnotationView?
        if let dequeueannotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationId) {
            annotationView = dequeueannotationView
            annotationView?.annotation = annotation
        } else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationId)
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
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        performSegue(withIdentifier: segueIdentifier, sender: nil)
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