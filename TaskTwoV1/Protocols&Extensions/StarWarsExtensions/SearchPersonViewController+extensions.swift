//
//  SearchPersonViewController+extensions.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 18.07.2021.
//

import UIKit

extension SearchPersonViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as? ItemCollectionViewCell else {
            fatalError()
        }
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                      didSelectItemAt indexPath: IndexPath) {
     print("DID select item\(indexPath)")
       let item = viewModels[indexPath.item]
       performSegue(withIdentifier: segueIdentifier, sender: item)
  }
}
    extension SearchPersonViewController: UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            sizeForItemAt indexPath: IndexPath) -> CGSize {
            let frameCV = collectionView.frame
            let widthCell = frameCV.width/CGFloat(countCells)
            let heightCell = widthCell
            let spasing = CGFloat((countCells + 1)) * offset / CGFloat(countCells)
            return CGSize(width: widthCell - spasing, height: heightCell - (offset*2))
        }
    }
extension SearchPersonViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked (_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }

        print(text)
        APIService.shared.searchPeopleList(with: text) { [weak self] result in
            switch result {
            case.success(let results):
                self?.results = results
                self?.viewModels = results.compactMap({
                    CellTableViewModel(
                        title: $0.name ,
                        subtitle: $0.gender )
                })

                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            case.failure(let error):
            print(error)
            }
        }
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }

        print(text)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        collectionView.reloadData()
    }
}
