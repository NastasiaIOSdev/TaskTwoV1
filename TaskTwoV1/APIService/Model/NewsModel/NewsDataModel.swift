//
//  NewsViewModel.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 18.08.2021.
//

import Foundation
import UIKit

struct NewsFilters: Codable {
    let categoryOptions: [String]
    var sourceOptions: [SourceFilter] = []
}

enum FilterType: String, CaseIterable {
    case source = "Source", category = "Category"
    static var asArray: [FilterType] {
        return self.allCases
    }

    func asInt() -> Int {
        return FilterType.asArray.firstIndex(of: self)!
    }
}

protocol NewsViewModelDelegate: class {
    func onFetchCompleted(with newIndexParhsToreload: [IndexPath]?)
    func onFetchFailed(with reasonL: String)
}

class NewsDataModel {
    weak var delegate: NewsViewModelDelegate?
    var isFerchInProgress = false
    let apiClient = APIService()
    let pageSize = 30
    let responseNumber = 100
    var totalArticlesCount = 0
    var currentPage = 0

    var fetchedArticles: [Article] = []
    var fetchedArticleImages: [UIImage] = []
    var filterOptions: [String: [String]] = [:]
    var chosenFilters: [String: [String]] = [:]
    private var filters: NewsFilters!

    init(delegate: NewsViewModelDelegate) {
        self.delegate = delegate
        guard let filters = HelperMethods.readFiltersInfoJSON() else {
            print("An error with filters fetch from JSON has occured")
            return
    }
        self.filters = filters
        apiClient.getSourceFilters { (sourceOptions, error) in
            DispatchQueue.main.async {
                if sourceOptions.count > 0 {
                    self.filters.sourceOptions = sourceOptions
                    self.filterOptions["Source"] = sourceOptions.map({$0.name})
                    self.filterOptions["Category"] = self.filters.categoryOptions
                    guard let newsListVc = self.delegate as? NewsViewController else { return }
                    newsListVc.filterButton.isEnabled = true
                } else {
                    print(error?.localizedDescription ?? "An error with sources fetch has occured")
                }
            }
        }
    }

    func fetchNewsData(searchQuery: String) {
        guard !isFerchInProgress else {return}
        isFerchInProgress = true
        apiClient.getNewsInfo(currentPage: currentPage, pageSize: pageSize, filters: chosenFilters, searchQuery: searchQuery) { (response, error) in
            DispatchQueue.main.async {
                self.isFerchInProgress = false
                guard let response = response else {
                    self.delegate?.onFetchFailed(with: error?.localizedDescription ?? "An error has occured")
                    return
                }
                self.currentPage += 1
                self.fetchedArticles.append(contentsOf: response.articles)
                self.totalArticlesCount = response.totalResults < self.responseNumber ? response.totalResults : self.responseNumber
                if self.currentPage > 1 {
                    let indexPathsToReload = self.calculateIndexPathsToReload(from: response.articles, total: response.totalResults)
                    self.delegate?.onFetchCompleted(with: indexPathsToReload)
                } else {
                    self.delegate?.onFetchCompleted(with: .none)
                }
            }
        }
    }

    func calculateIndexPathsToReload(from newArticles: [Article], total: Int) -> [IndexPath] {
        let startIndex = total - newArticles.count
        let endIndex = startIndex + newArticles.count
        var indexPaths: [IndexPath] = []
        for index in startIndex..<endIndex {
            indexPaths.append(IndexPath(row: index, section: 0))
        }
        return indexPaths
    }
}
