//
//  TestDetailViewController.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 16.07.2021.
//

import UIKit

class TestDetailViewController: UIViewController {

    // MARK: - IBOUtlets

    @IBOutlet weak var testCollectionView: UICollectionView!

    var viewModel: BreedImagesModel?
    let countCells = 2
    let offset: CGFloat = 2.0

    override func viewDidLoad() {
        super.viewDidLoad()
        testCollectionView.register(UINib(nibName: "TestCollectionViewCell", bundle: nil),
                                    forCellWithReuseIdentifier: "TestCollectionViewCell")
        title = viewModel?.breed?.capitalized
    }
}
