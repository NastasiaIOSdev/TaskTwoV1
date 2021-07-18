//
//  TestViewController+Extensions.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 18.07.2021.
//

import UIKit

extension TestViewController:  UICollectionViewDelegate {
    
}

extension TestViewController:  UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row % 3 == 0 {
            if let cell = collectionTestView.dequeueReusableCell(withReuseIdentifier: "FirstCollectionViewCell", for: indexPath) as? FirstCollectionViewCell {
                
                let vc = storyboard?.instantiateViewController(identifier: "TestDetailViewController") as! TestDetailViewController
                vc.viewModels = viewModels
                vc.indexPath = indexPath
                self.navigationController?.pushViewController(vc, animated: true)
                cell.collectionViewTestSecond.delegate = cell
                cell.collectionViewTestSecond.dataSource = cell
            }
        } else if (indexPath.row - 1) % 3 == 0 || indexPath.row == 1 {
            if let cell2 = collectionTestView.dequeueReusableCell(
                withReuseIdentifier: "SecondCollectionViewCell", for: indexPath) as? SecondCollectionViewCell {
                
                let vc = storyboard?.instantiateViewController(identifier: "TestDetailViewController") as! TestDetailViewController
                vc.viewModels = viewModels
                vc.indexPath = indexPath
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else if (indexPath.row - 1) % 2 == 0 || (indexPath.row - 1) % 2 == 1 || indexPath.row == 2 {
            if let cell3 = collectionTestView.dequeueReusableCell(
                withReuseIdentifier: "ThirdCollectionViewCell", for: indexPath) as? ThirdCollectionViewCell {
                
//                let vc = storyboard?.instantiateViewController(identifier: "TestDetailViewController") as! TestDetailViewController
//                vc.viewModels = viewModels
//                vc.indexPath = indexPath
//                self.navigationController?.pushViewController(vc, animated: true)
//                cell3.collectionViewTestThird.delegate = self
//                cell3.collectionViewTestThird.dataSource = self
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row % 3 == 0 {
            if let cell = collectionTestView.dequeueReusableCell(withReuseIdentifier: "FirstCollectionViewCell", for: indexPath) as? FirstCollectionViewCell {
                cell.configure(with: viewModels)
                return cell
            }
        } else if (indexPath.row - 1) % 3 == 0 || indexPath.row == 1 {
            if let cell2 = collectionTestView.dequeueReusableCell(
                withReuseIdentifier: "SecondCollectionViewCell", for: indexPath) as? SecondCollectionViewCell {
                cell2.configure(with: viewModels[indexPath.row])
                return cell2
            }
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

extension TestViewController:  UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionTestView.frame.width, height: collectionTestView.frame.height/3 - 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
    }
}
