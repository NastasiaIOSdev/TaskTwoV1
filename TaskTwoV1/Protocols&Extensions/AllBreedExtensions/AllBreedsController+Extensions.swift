//
//  TestViewController+Extensions.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 18.07.2021.
//

import UIKit

extension AllBreedsViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        cell.alpha = 0
        let transform = CATransform3DTranslate(CATransform3DIdentity, -250, 20, 0)
        cell.layer.transform = transform

        UIView.animate(withDuration: 0.9) {
            cell.alpha = 1
            cell.layer.transform = CATransform3DIdentity
        }
    }
}

extension AllBreedsViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if indexPath.row % 3 == 0 {
            if let cell = collectionTestView.dequeueReusableCell(withReuseIdentifier: "FirstCollectionViewCell",
                                                                 for: indexPath) as? FirstCollectionViewCell {
                cell.configure(with: viewModels, viewC: self)
                return cell
            }

        } else if (indexPath.row - 1) % 3 == 0 || indexPath.row == 1 {
            guard let cell2 = collectionTestView.dequeueReusableCell(
                    withReuseIdentifier: "SecondCollectionViewCell",
                    for: indexPath) as? SecondCollectionViewCell else { fatalError()
            }
            cell2.breeds = self.breeds
            cell2.parentViewController = self
            return cell2

            } else if (indexPath.row - 1) % 2 == 0 || (indexPath.row - 1) % 2 == 1 || indexPath.row == 2 {
            if let cell3 = collectionTestView.dequeueReusableCell(
                withReuseIdentifier: "ThirdCollectionViewCell", for: indexPath) as? ThirdCollectionViewCell {
                cell3.configure(with: viewModels, viewC: self)
                return cell3
            }
        }
        return UICollectionViewCell()
    }

}
extension AllBreedsViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionTestView.frame.width, height: collectionTestView.frame.height/3 - 10)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
    }
}
