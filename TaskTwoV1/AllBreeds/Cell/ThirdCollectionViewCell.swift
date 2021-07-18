//
//  ThirdCollectionViewCell.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 16.07.2021.
//

import UIKit

class ThirdCollectionViewCell: UICollectionViewCell  {
    
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
}
