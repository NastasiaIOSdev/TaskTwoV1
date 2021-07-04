//
//  ThirdTableViewCell.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 03.07.2021.
//

import UIKit

class ThirdTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
 
    static let identifier = "ThirdTableViewCell"
 
    // MARK: - IBOutlets
    
    @IBOutlet weak var collectionViewSecond: UICollectionView!
    
    var models = [CellViewModel]()
    
     static func nib() -> UINib {
         return UINib(nibName: "ThirdTableViewCell", bundle: nil)
     }
    
    func configure(with models: [CellViewModel]) {
        self.models = models
        collectionViewSecond.reloadData()
    }

     override func awakeFromNib() {
         super.awakeFromNib()
        collectionViewSecond.register(ThirdTableViewCell.nib(), forCellWithReuseIdentifier: ThirdTableViewCell.identifier)
        collectionViewSecond.delegate = self
        collectionViewSecond.dataSource = self
     }
    
    //MARK: - CollectionView
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewSecond.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifaer, for: indexPath) as! CollectionViewCell
       cell.configure(with: models[indexPath.row])
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
}
