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
        let model = self.models[indexPath.row]
        APIService.shared.getPhotos(breedId: model.breedId) { [self] result in
            switch result {
            case.success(let images):
                let newImages = images.compactMap({ catImage in
                    catImage.url
                })
                DispatchQueue.main.async {
                    self.parentViewController?.makeSegue(data: BreedImagesModel(breed: model.title, images: newImages))
                }
            case .failure(let error):
                print(error)
            }
        }
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
