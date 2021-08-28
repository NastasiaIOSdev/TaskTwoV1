//
//  NewsViewController+Extensions.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 19.08.2021.
//

import UIKit

// MARK: - CollectionView Delegate & DataSource

extension NewsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching {

    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            newsModel.fetchNewsData(searchQuery: "")
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsModel.totalArticlesCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if self.listType == 1 {

            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GridCell.reuseIdentifierListCell, for: indexPath) as? GridCell else {
                fatalError()
            }
            var currentArticle = isLoadingCell(for: indexPath) ? nil : newsModel.fetchedArticles[indexPath.row]
            cell.configure(with: &currentArticle, targetVC: self)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GridCell.reuseIdentifierGridCell, for: indexPath) as? GridCell else {
                fatalError()
            }
            var currentArticle = isLoadingCell(for: indexPath) ? nil : newsModel.fetchedArticles[indexPath.row]
            cell.configure(with: &currentArticle, targetVC: self)
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if newsModel.fetchedArticles.count > indexPath.row {
            let item = newsModel.fetchedArticles[indexPath.row]
            performSegue(withIdentifier: segueIdentifier, sender: item)
            print("DID select item\(indexPath)")
        }
    }
}

// MARK: - FloyLayoyt

extension NewsViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / (self.listType == 2 ? 2 : 1) - 10, height: collectionView.frame.height/4 - 15)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
    }
}

// MARK: SearchBar Delegate

extension NewsViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        refresh(sender: self)
        newsModel.fetchNewsData(searchQuery: searchBar.text ?? "")
        searchBar.text = ""
    }
}

// MARK: - NewsViewModelDelegate

extension NewsViewController: NewsViewModelDelegate {
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?) {
        guard let newIndexPathsToReload = newIndexPathsToReload else {
            collectionView.reloadData()
            return
        }
        let indexPathsToReload = visibleIndexPathsToReload(indexPaths: newIndexPathsToReload)
        collectionView.reloadItems(at: indexPathsToReload)
    }

    func onFetchFailed(with reason: String) {
        HelperMethods.showFailureAlert(title: "Warning", message: reason, controller: self)
    }
}

// MARK: - PopupDelegate

extension NewsViewController: PopupDelegate {
    func popupValueSelected(value: [String: [String]]) {
        newsModel.chosenFilters = value
        newsModel.totalArticlesCount = 100
        refresh(sender: self)
    }
}

extension UIImage {
    func getImageRatio() -> CGFloat {
        return CGFloat(self.size.width / self.size.height)
    }
}

extension NewsViewController {
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= newsModel.fetchedArticles.count
    }

    func visibleIndexPathsToReload(indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = collectionView.indexPathsForVisibleItems
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
}
