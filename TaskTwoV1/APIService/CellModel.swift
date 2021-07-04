//
//  CellModel.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 05.07.2021.
//

import Foundation

class CellModel {
    let title: String
    let imageUrl: URL?
    var imageData: Data? = nil
    
    init (
        title: String,
        imageUrl: URL?
    ) {
        self.title = title
        self.imageUrl = imageUrl
    }
}
