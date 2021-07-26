//
//  FullscreenViewController.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 17.07.2021.
//

import UIKit

class FullscreenViewController: UIViewController {

    // MARK: - IBOUtlets

    @IBOutlet weak var collectionView: UICollectionView!

    var viewModels = [CellViewModel]()

    let countCells = 1
    let offset: CGFloat = 2.0
    var indexPath: IndexPath!

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "FullscreenCollectionViewCell", bundle: nil),
                                forCellWithReuseIdentifier: "FullscreenCollectionViewCell")
        title = "Breed photo"
        collectionView.performBatchUpdates(nil) { (_) in
            self.collectionView.scrollToItem(at: self.indexPath, at: .centeredHorizontally, animated: false)
        }
    }
}
