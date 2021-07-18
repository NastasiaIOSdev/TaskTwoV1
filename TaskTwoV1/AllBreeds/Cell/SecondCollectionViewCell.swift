//
//  SecondCollectionViewCell.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 16.07.2021.
//

import UIKit

class SecondCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "SecondCollectionViewCell"
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var collectionViewTestSecond: UICollectionView!
    
    var models = [CellViewModel]()
    
    static func nib() -> UINib {
        return UINib(nibName: "SecondCollectionViewCell", bundle: nil)
    }
    
    func configure(with models: [CellViewModel]) {
        self.models = models
        collectionViewTestSecond.reloadData()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionViewTestSecond.register(
            InsideSecondCollectionViewCell.nib(),
            forCellWithReuseIdentifier: InsideSecondCollectionViewCell.identifier)
        collectionViewTestSecond.delegate = self
        collectionViewTestSecond.dataSource = self
    }
}
