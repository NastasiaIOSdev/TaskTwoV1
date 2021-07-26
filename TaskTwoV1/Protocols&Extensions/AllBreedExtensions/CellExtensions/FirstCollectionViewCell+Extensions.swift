//
//  FirstCollectionViewCell+Extensions.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 18.07.2021.
//

import UIKit

extension FirstCollectionViewCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionViewTestSecond.frame.width, height: collectionViewTestSecond.frame.height)
    }
}

extension FirstCollectionViewCell: UICollectionViewDelegate,
                                   UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewC = TestDetailViewController()
        viewC.modalPresentationStyle = .overFullScreen
        viewC.viewModels = models
        viewC.indexPath = indexPath
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionViewTestSecond.dequeueReusableCell(
                withReuseIdentifier: InsideFirstCollectionViewCell.identifaer,
                for: indexPath) as? InsideFirstCollectionViewCell else { fatalError()
        }
        cell.configure(with: models[indexPath.row])
        return cell
    }
}
