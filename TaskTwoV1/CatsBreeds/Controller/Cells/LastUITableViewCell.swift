//
//  LastUITableViewCell.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 11.07.2021.
//

import UIKit

class LastUITableViewCell: UITableViewCell, UICollectionViewDelegate,
                           UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  static let identifier = "LastUITableViewCell"

     // MARK: - IBOutlets

     @IBOutlet weak var collectionViewSecond: UICollectionView!

     var models = [CellViewModel]()

      static func nib() -> UINib {
          return UINib(nibName: "LastUITableViewCell", bundle: nil)
      }

     func configure(with models: [CellViewModel]) {
         self.models = models
         collectionViewSecond.reloadData()
     }

      override func awakeFromNib() {
          super.awakeFromNib()

         collectionViewSecond.register(
            LastUICollectionViewCell.nib(),
             forCellWithReuseIdentifier: LastUICollectionViewCell.identifaer)
         collectionViewSecond.delegate = self
         collectionViewSecond.dataSource = self
      }

     // MARK: - CollectionView

     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return models.count
     }

     func collectionView(_ collectionView: UICollectionView,
                         cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionViewSecond.dequeueReusableCell(
                 withReuseIdentifier: LastUICollectionViewCell.identifaer,
                 for: indexPath) as? LastUICollectionViewCell else { fatalError()
         }
        cell.configure(with: models[indexPath.row])
     return cell
     }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionViewSecond.frame.width/3 - 10, height: collectionViewSecond.frame.height - 10)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }

 }
