//
//  TestViewController+Extensions.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 18.07.2021.
//

import UIKit

extension TestViewController: UICollectionViewDelegate {

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

extension TestViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row % 3 == 0 {
            if let cell = collectionTestView.dequeueReusableCell(withReuseIdentifier: "FirstCollectionViewCell",
                                                                 for: indexPath) as? FirstCollectionViewCell {

                guard let viewC = storyboard?.instantiateViewController(
                        identifier: "TestDetailViewController")
                        as? TestDetailViewController else {
                    fatalError()
                }
                viewC.viewModels = viewModels
                viewC.indexPath = indexPath
                self.navigationController?.pushViewController(viewC, animated: true)
                cell.collectionViewTestSecond.delegate = cell
                cell.collectionViewTestSecond.dataSource = cell
            }
        } else if (indexPath.row - 1) % 3 == 0 || indexPath.row == 1 {
            if collectionTestView.dequeueReusableCell(
                withReuseIdentifier: "SecondCollectionViewCell",
                for: indexPath) is SecondCollectionViewCell {

                guard let viewC = storyboard?.instantiateViewController(
                        identifier: "TestDetailViewController")
                        as? TestDetailViewController else {
                    fatalError()
                }
                viewC.viewModels = viewModels
                viewC.indexPath = indexPath
                self.navigationController?.pushViewController(viewC, animated: true)
            }
        } else if (indexPath.row - 1) % 2 == 0 || (indexPath.row - 1) % 2 == 1 || indexPath.row == 2 {
            if collectionTestView.dequeueReusableCell(
                withReuseIdentifier: "ThirdCollectionViewCell", for: indexPath) is ThirdCollectionViewCell {

            }
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if indexPath.row % 3 == 0 {
            if let cell = collectionTestView.dequeueReusableCell(withReuseIdentifier: "FirstCollectionViewCell",
                                                                 for: indexPath) as? FirstCollectionViewCell {
                cell.configure(with: viewModels)
                return cell
            }

        } else if (indexPath.row - 1) % 3 == 0 || indexPath.row == 1 {
            guard let breed = self.breeds?.message[indexPath.row].capitalized else {return UICollectionViewCell.init()}

            guard let cell2 = collectionTestView.dequeueReusableCell(
                    withReuseIdentifier: "FirstDogCollectionViewCell",
                    for: indexPath) as? FirstDogCollectionViewCell else { fatalError()
            }
            for (index, image) in self.breeds!.message.enumerated() where index == indexPath.row {
                    APIService.shared.getPhoto(breeds: image) { result in
                        switch result {
                        case .success(let img):
                            DispatchQueue.main.async {
                                cell2.setBreed(breed: breed, imageURL: img.message)
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
            }
            return cell2
            } else if (indexPath.row - 1) % 2 == 0 || (indexPath.row - 1) % 2 == 1 || indexPath.row == 2 {
            if let cell3 = collectionTestView.dequeueReusableCell(
                withReuseIdentifier: "ThirdCollectionViewCell", for: indexPath) as? ThirdCollectionViewCell {
                cell3.configure(with: viewModels)
                return cell3
            }
        }
        return UICollectionViewCell()
    }

}
extension TestViewController: UICollectionViewDelegateFlowLayout {

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
