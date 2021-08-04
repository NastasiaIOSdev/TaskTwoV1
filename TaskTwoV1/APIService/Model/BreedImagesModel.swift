//
//  BreedImagesModel.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 04.08.2021.
//

import Foundation
import UIKit

struct BreedImagesModel {
    let breed: String?
    var images: [String]

    init(cellViewModel model: CellViewModel) {
        breed = model.title
        images = []
        if let image = model.imageUrl?.absoluteString {
            images = [image]
        }
    }

    init(breed: String?, images: [String]) {
        self.breed = breed
        self.images = images
    }
}
