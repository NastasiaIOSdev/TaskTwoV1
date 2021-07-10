//
//  LastTableViewCell.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 10.07.2021.
//

import UIKit

class LastTableViewCell: UITableViewCell, UICollectionViewDelegate,
                         UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    static let identifier = "LastTableViewCell"
    // MARK: - IBOutlets
    @IBOutlet weak var collectionViewLast: UICollectionView!
    @IBOutlet weak var lastPageControl: UIPageControl!
    var currentCellIndex = 0
    var models = [CellViewModel]()
    @objc func slideToNext() {
        if currentCellIndex < 4 {
            currentCellIndex += 1
        } else {
            currentCellIndex = 0
        }
        lastPageControl.currentPage = currentCellIndex
        collectionViewLast.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .right, animated: true)
    }
    override func layoutSubviews() {
        }
    static func nib() -> UINib {
        return UINib(nibName: "LastTableViewCell", bundle: nil)
    }
    func configure(with models: [CellViewModel]) {
        self.models = models
        collectionViewLast.reloadData()
        slideToNext()
        lastPageControl.numberOfPages = 3
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionViewLast.register(
            LastCollectionViewCell.nib(),
            forCellWithReuseIdentifier: LastCollectionViewCell.identifaer)
        collectionViewLast.delegate = self
        collectionViewLast.dataSource = self
        lastPageControl.numberOfPages = 3
    }
    // MARK: - CollectionView
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 3 }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionViewLast.dequeueReusableCell(
                withReuseIdentifier: LastCollectionViewCell.identifaer,
                for: indexPath) as? LastCollectionViewCell else { fatalError()
        }
        cell.configure(with: models[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionViewLast.frame.width, height: collectionViewLast.frame.height)
    }
}
