//
//  FullscreenViewController+Extensions.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 18.07.2021.
//

import UIKit

extension FullscreenViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.image != nil ? 1 : 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FullscreenCollectionViewCell",
                                                            for: indexPath) as? FullscreenCollectionViewCell else {
            fatalError()
        }
        cell.configure(with: self.image)
        return cell
    }
}

extension FullscreenViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameCV = collectionView.frame
        let widthCell = frameCV.width/CGFloat(countCells)
        let heightCell = widthCell
        return CGSize(width: widthCell, height: heightCell)
    }
}
