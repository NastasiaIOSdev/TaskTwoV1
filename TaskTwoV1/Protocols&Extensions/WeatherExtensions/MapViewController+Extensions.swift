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
import Foundation

extension MapViewController: MKMapViewDelegate {

    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        self.searchCompleter.region = mainMap.region
    }

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

extension MapViewController: UISearchBarDelegate {

    func showLocation() {
        geocoder.geocodeAddressString(searchBar.text!) { (placemarks: [CLPlacemark]?, error: Error?) in

            if error == nil {
                let placemark = placemarks?.first
                let annotation = MKPointAnnotation()
                var locCoord = annotation.coordinate
                locCoord = (placemark?.location?.coordinate)!
                annotation.title = self.searchBar.text!
                self.weatherManager.sendRequest(coordinates: locCoord) { weather in
                    DispatchQueue.main.async {
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = locCoord
                        if let weather = weather {
                            annotation.subtitle = "\(weather.main.temp)"
                        } else {
                            annotation.subtitle = "error data"
                        }
                        let allAnnotation = self.mainMap.annotations
                        self.mainMap.removeAnnotations(allAnnotation)
                        self.mainMap.addAnnotation(annotation)
                        self.mainMap.selectAnnotation(annotation, animated: true)
                    }
                }

                let spam = MKCoordinateSpan(latitudeDelta: self.zoomLevelDelta, longitudeDelta: self.zoomLevelDelta)
                let region = MKCoordinateRegion(center: annotation.coordinate, span: spam)

                self.mainMap.setRegion(region, animated: true)
                self.mainMap.addAnnotation(annotation)
                self.mainMap.selectAnnotation(annotation, animated: true)
            } else {
                print("Error")
            }
        }
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        ignoresearchResults = false
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchCompleter.queryFragment = searchText
        if searchText == "" {
            setSearchresults([])
            searchresultsTableView.reloadData()
        }
    }
}

extension MapViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        ignoresearchResults = true
        let completion = searchResults[indexPath.row]
        searchBar.text = completion.title
        let searchRequest = MKLocalSearch.Request(completion: completion)
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, _) in
            let coordinate = response?.mapItems[0].placemark.coordinate
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate!
            annotation.title = completion.title

            let spam = MKCoordinateSpan(latitudeDelta: self.zoomLevelDelta, longitudeDelta: self.zoomLevelDelta)
            let region = MKCoordinateRegion(center: annotation.coordinate, span: spam)
            self.mainMap.setRegion(region, animated: true)
            self.mainMap.addAnnotation(annotation)
            self.mainMap.selectAnnotation(annotation, animated: true)

            self.searchBar.resignFirstResponder()
            self.setSearchresults([])
            self.searchresultsTableView.reloadData()
        }
    }
}

extension MapViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchResult = searchResults[indexPath.row]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)

        cell.textLabel?.attributedText = hightLightedText(searchResult.title, inRanges: searchResult.titleHighlightRanges, size: 17.0)
        cell.detailTextLabel?.attributedText = hightLightedText(searchResult.subtitle, inRanges: searchResult.subtitleHighlightRanges, size: 12.0)
        cell.backgroundColor = UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 0.65)
        return cell
    }
}

extension MapViewController: MKLocalSearchCompleterDelegate {

    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        if ignoresearchResults == false {
            setSearchresults(completer.results)
            searchresultsTableView.reloadData()
        }
}

    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print("Error")
    }
}
