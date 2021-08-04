//
//  ThirdCollectionViewCell+Extensions.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 18.07.2021.
//

import UIKit

extension ThirdCollectionViewCell: UICollectionViewDelegate,
                                   UICollectionViewDataSource, UIScrollViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.parentViewController?.makeSegue(data: BreedImagesModel(cellViewModel: self.models[indexPath.row]))
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionViewTestThird.dequeueReusableCell(
                withReuseIdentifier: InsideThirdCollectionViewCell.identifaer,
                for: indexPath) as? InsideThirdCollectionViewCell else { fatalError()
        }
        cell.configure(with: models[indexPath.row])
        return cell
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
pageControl?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
pageControl?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}

extension ThirdCollectionViewCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionViewTestThird.frame.width, height: collectionViewTestThird.frame.height)
    }
}
