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

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UISearchBarDelegate {

    let locationManager = CLLocationManager()

    // MARK: - IBOutlets

    @IBOutlet weak var mainMap: MKMapView!

    // MARK: - Action

    @IBAction func searchBtn(_ sender: UIBarButtonItem) {
        let searchController = UISearchController(searchResultsController: nil)
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

    // MARK: - lifeCycles

    override func viewDidLoad() {
        super.viewDidLoad()
        mainMap.delegate = self
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        mainMap.showsUserLocation = true
        setupPin()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func setupPin() {
        let region: CLLocationDistance = 1500
        func centerMap(location: CLLocation) {
            let coordinate = MKCoordinateRegion(center: location.coordinate,
                                                latitudinalMeters: region,
                                                longitudinalMeters: region)
            mainMap.setRegion(coordinate, animated: true)
        }
        let pin = PinInfo(coordinatePin: CLLocationCoordinate2D(
                            latitude: 55.165218,
                            longitude: 61.366593),
                          description: "Park",
                          titlePin: "Good park",
                          namePin: "Gagarin park")
        mainMap.addAnnotation(pin)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        UIApplication.shared.beginIgnoringInteractionEvents()
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)

        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchBar.text
        let activeSearch = MKLocalSearch(request: searchRequest)
        activeSearch.start { (response, error) in UIApplication.shared.endIgnoringInteractionEvents()
            if response == nil {
                print(error.self ?? "Error")
            } else {
                let annotations = self.mainMap.annotations
                self.mainMap.removeAnnotations(annotations)

                let latitude = response?.boundingRegion.center.latitude
                let longitude = response?.boundingRegion.center.longitude

                let annotation = MKPointAnnotation()
                annotation.title = searchBar.text
                annotation.coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
                self.mainMap.addAnnotation(annotation)

                let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
                let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
                let region = MKCoordinateRegion(center: coordinate, span: span)
                self.mainMap.setRegion(region, animated: true)
            }
        }
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? PinInfo else {
            return nil
        }
        let identifier = "Some Description"
        var annotationView: MKMarkerAnnotationView
        if let myAnnotation = mapView.dequeueReusableAnnotationView(
            withIdentifier: identifier) as? MKMarkerAnnotationView {
            myAnnotation.annotation = annotation
            annotationView = myAnnotation
        } else {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView.canShowCallout = true
            annotationView.calloutOffset = CGPoint(x: -4, y: 4)
            annotationView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return annotationView
    }
}
