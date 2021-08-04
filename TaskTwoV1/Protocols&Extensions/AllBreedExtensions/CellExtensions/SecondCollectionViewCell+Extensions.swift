//
//  SecondCollectionViewCell+Extensions.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 18.07.2021.
//

import UIKit

extension SecondCollectionViewCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionViewTestSecond.frame.width/2 - 10,
                      height: collectionViewTestSecond.frame.height - 10)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
}

extension SecondCollectionViewCell: UICollectionViewDelegate,
                                   UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.breeds?.message.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let breed = self.breeds?.message[indexPath.row] {
            APIService.shared.getPhotoHound(breed) {[weak self] result in
                DispatchQueue.main.async { [weak self] in
                    var images: [String] = []
                    switch result {
                    case.success(let data):
                        images = data.message
                    case.failure(let error):
                        print(error)
                    }
                    self?.parentViewController?.makeSegue(data: BreedImagesModel(breed: breed, images: images))
                }
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionViewTestSecond.dequeueReusableCell(
                withReuseIdentifier: FirstDogCollectionViewCell.identifier,
                for: indexPath) as? FirstDogCollectionViewCell else { fatalError()
        }
        if let breed = self.breeds?.message[indexPath.row] {
            cell.setBreed(breed)
        }
        return cell
    }
}
