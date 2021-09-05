//
//  LastUITableViewCell.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 11.07.2021.
//

import UIKit

class LastUITableViewCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "LastUITableViewCell"
    var models = [CellViewModel]()

    // MARK: - IBOutlets

    @IBOutlet weak var collectionViewSecond: UICollectionView!

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
}
