//
//  TestDetailViewController+Extensions.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 18.07.2021.
//

import UIKit

extension AllBreedsDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        cell.alpha = 0
        let transform = CATransform3DTranslate(CATransform3DIdentity, -250, 20, 0)
        cell.layer.transform = transform

        UIView.animate(withDuration: 1.2) {
            cell.alpha = 1
            cell.layer.transform = CATransform3DIdentity
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = testCollectionView.dequeueReusableCell(withReuseIdentifier: "AllBreedsDetailCollectionViewCell",
                                                                for: indexPath) as? AllBreedsDetailCollectionViewCell else {
            fatalError()
        }
        cell.configure(with: photoCacheService.photo(atIndexpath: indexPath, byUrl: self.images[indexPath.row]))
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewC = storyboard?.instantiateViewController(identifier: "AllBreedsFullscreenViewController")
                                                                    as? AllBreedsFullscreenViewController else {
            fatalError()
        }
        guard self.collectionView(collectionView, cellForItemAt: indexPath) is AllBreedsDetailCollectionViewCell else {
            fatalError()
        }
        viewC.imageUrlString = self.images[indexPath.row]
        self.navigationController?.pushViewController(viewC, animated: true)
    }
}

extension AllBreedsDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameCV = testCollectionView.frame
        let widthCell = frameCV.width/CGFloat(countCells)
        let heightCell = widthCell
        let spasing = CGFloat((countCells + 1)) * offset / CGFloat(countCells)
        return CGSize(width: widthCell - spasing, height: heightCell - (offset*2))
    }
}
