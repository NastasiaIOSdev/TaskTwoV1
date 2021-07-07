//
//  ThirdViewPagerTableViewCell.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 05.07.2021.
//

import UIKit

class ThirdViewPagerTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    static let identifier = "ThirdViewPagerTableViewCell"
 
    // MARK: - IBOutlets
    
    @IBOutlet weak var pagerCollectionView: UICollectionView!
    
    var models = [CellViewModel]()
    
     static func nib() -> UINib {
         return UINib(nibName: "ThirdViewPagerTableViewCell", bundle: nil)
     }
    
    func configure(with models: [CellViewModel]) {
        self.models = models
        pagerCollectionView.reloadData()
    }

     override func awakeFromNib() {
         super.awakeFromNib()
        pagerCollectionView.register(ThirdCollectionViewCell.nib(), forCellWithReuseIdentifier: ThirdCollectionViewCell.identifaer)
        pagerCollectionView.delegate = self
        pagerCollectionView.dataSource = self
     }
    
    //MARK: - CollectionView
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = pagerCollectionView.dequeueReusableCell(withReuseIdentifier: ThirdCollectionViewCell.identifaer, for: indexPath) as? ThirdCollectionViewCell else { fatalError()
        }
       cell.configure(with: models[indexPath.row])
    return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 320, height: 150)
        // return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
}
    

