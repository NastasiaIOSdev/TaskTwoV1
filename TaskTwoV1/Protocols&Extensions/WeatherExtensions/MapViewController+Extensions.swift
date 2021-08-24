//
//  MapViewController+Extensions.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 24.08.2021.
//

import UIKit
import MapKit
import Contacts
import CoreLocation
import Network

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
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView?.tintColor = .systemPink
        }
        if let annotationView = annotationView {
            annotationView.canShowCallout = true
            annotationView.image = UIImage(named: "img_pin")
        }
        return annotationView
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let weatherdetailViewController = storyboard.instantiateViewController(identifier: "WeatherDetailViewController") as? WeatherDetailViewController,
           let annotation = self.mainMap.annotations.first {
            weatherdetailViewController.locationCoordinates = annotation.coordinate
            show(weatherdetailViewController, sender: nil)
        }
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

        geocoder.geocodeAddressString(searchBar.text!) { [zoomLevelDelta] (placemarks: [CLPlacemark]?, error: Error?) in

            if let error = error {
                print("Error: \(error)")
            } else if let location = placemarks?.first?.location {
                let annotation = MKPointAnnotation()
                annotation.coordinate = location.coordinate
                annotation.title = searchBar.text!

                let spam = MKCoordinateSpan(latitudeDelta: zoomLevelDelta, longitudeDelta: zoomLevelDelta)
                let region = MKCoordinateRegion(center: annotation.coordinate, span: spam)

                self.mainMap.setRegion(region, animated: true)
                self.mainMap.addAnnotation(annotation)
                self.mainMap.selectAnnotation(annotation, animated: true)
            }
        }
    }
}
