//
//  ThirdCollectionViewCell.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 16.07.2021.
//

import UIKit

class ThirdCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties

    static let identifier = "ThirdCollectionViewCell"
    var parentViewController: AllBreedsViewController?
    var models = [CellViewModel]()

    // MARK: - IBOutlets

    @IBOutlet weak var collectionViewTestThird: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!

    static func nib() -> UINib {
        return UINib(nibName: "ThirdCollectionViewCell", bundle: nil)

    }

    func configure(with models: [CellViewModel], viewC: AllBreedsViewController?) {
        self.models = models
        self.parentViewController = viewC
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
