//
//  ThirdCollectionViewCell.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 16.07.2021.
//

import UIKit

class ThirdCollectionViewCell: UICollectionViewCell, UICollectionViewDelegate,
                               UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIPageViewControllerDelegate {
      static let identifier = "ThirdCollectionViewCell"

         // MARK: - IBOutlets

         @IBOutlet weak var collectionViewTestThird: UICollectionView!
         @IBOutlet weak var pageControl: UIPageControl!

         var models = [CellViewModel]()

          static func nib() -> UINib {
              return UINib(nibName: "ThirdCollectionViewCell", bundle: nil)
          }

         func configure(with models: [CellViewModel]) {
             self.models = models
            collectionViewTestThird.reloadData()
         }

          override func awakeFromNib() {
              super.awakeFromNib()

            collectionViewTestThird.register(
                InsideThirdCollectionViewCell.nib(),
                 forCellWithReuseIdentifier: InsideThirdCollectionViewCell.identifaer)
            collectionViewTestThird.delegate = self
            collectionViewTestThird.dataSource = self
          }

         // MARK: - CollectionView

         func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
             return 3
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

         func collectionView(_ collectionView: UICollectionView,
                             layout collectionViewLayout: UICollectionViewLayout,
                             sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionViewTestThird.frame.width, height: collectionViewTestThird.frame.height)
         }

     }
