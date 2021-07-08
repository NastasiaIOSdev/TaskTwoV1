//
//  CellViewModel.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 30.06.2021.
//

import Foundation

class CellViewModel {
    let title: String
    let subtitle: String
    let imageUrl: URL?
    var imageData: Data?

    init (
        title: String,
        subtitle: String,
        imageUrl: URL?
    ) {
        self.title = title
        self.subtitle = subtitle
        self.imageUrl = imageUrl
    }
}
