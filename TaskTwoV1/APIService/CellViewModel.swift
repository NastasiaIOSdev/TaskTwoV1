//
//  CellViewModel.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 30.06.2021.
//

import Foundation
import UIKit

class CellViewModel {
    let title: String
    let subtitle: String
    let aboutBreed: String
    let imageUrl: URL?
    var imageData: Data?
    var imagesArray: [UIImage] = []
    
    init (
        title: String,
        subtitle: String,
        aboutBreed: String,
        imageUrl: URL?
        
    ) {
        self.title = title
        self.subtitle = subtitle
        self.aboutBreed = aboutBreed
        self.imageUrl = imageUrl
    }
}
