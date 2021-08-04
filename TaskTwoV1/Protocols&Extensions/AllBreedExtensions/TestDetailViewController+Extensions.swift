//
//  TestDetailViewController+Extensions.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 18.07.2021.
//

import UIKit

extension TestDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {

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
        return self.viewModel?.images.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = testCollectionView.dequeueReusableCell(withReuseIdentifier: "TestCollectionViewCell",
                                                                for: indexPath) as? TestCollectionViewCell else {
            fatalError()
        }
        if let image = self.viewModel?.images[indexPath.row] {
            cell.configure(with: image)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewC = storyboard?.instantiateViewController(identifier: "FullscreenViewController")
                                                                    as? FullscreenViewController else {
            fatalError()
        }
        guard self.collectionView(collectionView, cellForItemAt: indexPath) is TestCollectionViewCell else {
            fatalError()
        }
           if let image = self.viewModel?.images[indexPath.row] {
            viewC.imageUrlString = image
        }
        self.navigationController?.pushViewController(viewC, animated: true)
    }
}

extension TestDetailViewController: UICollectionViewDelegateFlowLayout {
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
