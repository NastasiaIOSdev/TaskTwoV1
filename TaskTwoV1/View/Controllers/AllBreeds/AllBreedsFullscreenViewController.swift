//
//  FullscreenViewController.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 17.07.2021.
//

import UIKit

class AllBreedsFullscreenViewController: UIViewController {

    // MARK: - IBOUtlets

    @IBOutlet weak var collectionView: UICollectionView!

    lazy var photoCacheService = PhotoCacheService.init(container: self.collectionView)

    let countCells = 1
    let offset: CGFloat = 2.0
    var imageUrlString: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "AllBreedsFullScreenCollectionViewCell", bundle: nil),
                                forCellWithReuseIdentifier: "AllBreedsFullScreenCollectionViewCell")
        title = "Breed photo"
    }
}