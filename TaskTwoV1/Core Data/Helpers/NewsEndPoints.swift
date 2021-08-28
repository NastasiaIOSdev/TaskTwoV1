//
//  NewsEndPoints.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 28.08.2021.
//

import Foundation
import UIKit

class NewsEndPoints {

    enum Endpoints {
        static let baseString = "https://newsapi.org/v2/"

        case topHeadlines
        case everything
        case sourceFilters

        var stringValue: String {
            switch self {
            case .topHeadlines: return Endpoints.baseString + "top-headlines"
            case .everything: return Endpoints.baseString + "everything"
            case .sourceFilters: return Endpoints.baseString + "sources"
            }
        }

        var url: URL {
            return URL(string: stringValue)!
        }
    }
}
