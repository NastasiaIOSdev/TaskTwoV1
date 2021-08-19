//
//  NewsViewController+Extensions.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 19.08.2021.
//

import UIKit

extension NewsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if self.listType == 1 {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GridCell.reuseIdentifierListCell, for: indexPath) as? GridCell else {
            fatalError()
        }
        cell.configure(with: viewModels[indexPath.row])
        return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GridCell.reuseIdentifierGridCell, for: indexPath) as? GridCell else {
                fatalError()
            }
            cell.configure(with: viewModels[indexPath.row])
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let item = viewModels[indexPath.row]
        performSegue(withIdentifier: segueIdentifier, sender: item)
        print("DID select item\(indexPath)")
    }
}

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
