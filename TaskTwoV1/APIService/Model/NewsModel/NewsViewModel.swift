//
//  NewsViewModel.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 18.08.2021.
//

import Foundation
import UIKit

class NewsViewModel {
    let title: String
    let subtitle: String
    let authorArticle: String
    let imageUrl: URL?
    var imageData: Data?

    init (
        title: String,
        subtitle: String,
        authorArticle: String,
        imageUrl: URL?
    ) {
        self.title = title
        self.subtitle = subtitle
        self.authorArticle = authorArticle
        self.imageUrl = imageUrl
    }

}
