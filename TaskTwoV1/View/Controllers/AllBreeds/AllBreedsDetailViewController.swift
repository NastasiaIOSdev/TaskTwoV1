//
//  TestDetailViewController.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 16.07.2021.
//

import UIKit

class AllBreedsDetailViewController: UIViewController {

    // MARK: - IBOUtlets

    @IBOutlet weak var testCollectionView: UICollectionView!
    lazy var photoCacheService = PhotoCacheService.init(container: self.testCollectionView)

    var model: BreedImagesModel?
    var images: [String] = []
    let countCells = 2
    let offset: CGFloat = 2.0

    override func viewDidLoad() {
        super.viewDidLoad()
        testCollectionView.register(UINib(nibName: "AllBreedsDetailCollectionViewCell", bundle: nil),
                                    forCellWithReuseIdentifier: "AllBreedsDetailCollectionViewCell")

        if let data = self.model {
            title = data.breed?.capitalized
            self.images = data.images
            self.testCollectionView.reloadData()
        }
    }
}
