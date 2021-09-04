//
//  FirstCollectionViewCell.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 16.07.2021.
//

import UIKit

class FirstCollectionViewCell: UICollectionViewCell {

    static let identifier = "FirstCollectionViewCell"

    // MARK: - IBOutlets

    @IBOutlet weak var collectionViewTestSecond: UICollectionView!

    var parentViewController: AllBreedsViewController?
    var models = [CellViewModel]()

    static func nib() -> UINib {
        return UINib(nibName: "FirstCollectionViewCell", bundle: nil)
    }

    func configure(with models: [CellViewModel], viewC: AllBreedsViewController?) {
        self.models = models
        self.parentViewController = viewC
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
}
