//
//  FirstCollectionViewCell.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 16.07.2021.
//

import UIKit

class FirstCollectionViewCell: UICollectionViewCell, UICollectionViewDelegate,
                               UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
      static let identifier = "FirstCollectionViewCell"

         // MARK: - IBOutlets

         @IBOutlet weak var collectionViewTestSecond: UICollectionView!

         var models = [CellViewModel]()

          static func nib() -> UINib {
              return UINib(nibName: "FirstCollectionViewCell", bundle: nil)
          }

         func configure(with models: [CellViewModel]) {
             self.models = models
            collectionViewTestSecond.reloadData()
         }

          override func awakeFromNib() {
              super.awakeFromNib()

            collectionViewTestSecond.register(
                InsideFirstCollectionViewCell.nib(),
                 forCellWithReuseIdentifier: InsideFirstCollectionViewCell.identifaer)
            collectionViewTestSecond.delegate = self
            collectionViewTestSecond.dataSource = self
          }
        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DelailCollectionViewController, let model = sender as? CellViewModel {
            vc.cellViewModel = model
            }
         }

         // MARK: - CollectionView
    
       func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      //  let CellViewModel = models[indexPath.row]
//        performSegue(withIdentifier: "Detail", sender: CellViewModel)
       }

         func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
             return models.count
         }

         func collectionView(_ collectionView: UICollectionView,
                             cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionViewTestSecond.dequeueReusableCell(
                     withReuseIdentifier: InsideFirstCollectionViewCell.identifaer,
                     for: indexPath) as? InsideFirstCollectionViewCell else { fatalError()
             }
            cell.configure(with: models[indexPath.row])
         return cell
         }

         func collectionView(_ collectionView: UICollectionView,
                             layout collectionViewLayout: UICollectionViewLayout,
                             sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionViewTestSecond.frame.width, height: collectionViewTestSecond.frame.height)
         }

     }
