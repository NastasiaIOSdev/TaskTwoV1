//
//  FullscreenViewController+Extensions.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 18.07.2021.
//

import UIKit

extension AllBreedsFullscreenViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AllBreedsFullScreenCollectionViewCell",
                                                            for: indexPath) as? AllBreedsFullScreenCollectionViewCell else {
            fatalError()
        }
        if let urlString = self.imageUrlString {
            cell.configure(with: photoCacheService.photo(atIndexpath: indexPath, byUrl: urlString))
        }
        return cell
    }
}

extension AllBreedsFullscreenViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameCV = collectionView.frame
        let widthCell = frameCV.width/CGFloat(countCells)
        let heightCell = widthCell
        return CGSize(width: widthCell, height: heightCell)
    }
}
