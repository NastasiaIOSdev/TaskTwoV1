//
//  SecondCollectionViewCell.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 16.07.2021.
//

import UIKit

class SecondCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties

    static let identifier = "SecondCollectionViewCell"
    var parentViewController: AllBreedsViewController?
    var breeds: Breed2?
    var images: [String] = []
    var houndImages: [String] = []

    // MARK: - IBOutlets

    @IBOutlet weak var collectionViewTestSecond: UICollectionView!

    static func nib() -> UINib {
        return UINib(nibName: "SecondCollectionViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        collectionViewTestSecond.register(
            FirstDogCollectionViewCell.nib(),
            forCellWithReuseIdentifier: FirstDogCollectionViewCell.identifier)
        collectionViewTestSecond.delegate = self
        collectionViewTestSecond.dataSource = self
    }
}
