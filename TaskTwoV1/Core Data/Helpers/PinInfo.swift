//
//  PinInfo.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 17.08.2021.
//

import UIKit
import MapKit
import Contacts

class PinInfo: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    let text: String
    let title: String?
    let pinName: String

    init(coordinatePin: CLLocationCoordinate2D, description: String, titlePin: String?, namePin: String) {
        self.coordinate = coordinatePin
        self.text = description
        self.title = titlePin
        self.pinName = namePin
        super.init()
    }

    func mapItem() -> MKMapItem {
        let addressDict = [CNPostalAddressCityKey: text]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }
}
