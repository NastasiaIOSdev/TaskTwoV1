//
//  PinInfo.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 27.07.2021.
//

import UIKit
import MapKit

class PinInfo: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    let desc: String
    let title: String?
    let pinName: String

    init(coordinatePin: CLLocationCoordinate2D, description: String, titlePin: String?, namePin: String) {
        self.coordinate = coordinatePin
        self.desc = description
        self.title = titlePin
        self.pinName = namePin
        super.init()
    }
    var sub: String {
        return desc
    }

}
