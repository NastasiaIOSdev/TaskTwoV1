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

    var viewModels = [CellViewModel]()
    let countCells = 2
    let offset: CGFloat = 2.0
    var indexPath: IndexPath!

    override func viewDidLoad() {
        super.viewDidLoad()
        testCollectionView.dataSource = self
        testCollectionView.delegate = self
        testCollectionView.register(UINib(nibName: "TestCollectionViewCell", bundle: nil),
                                    forCellWithReuseIdentifier: "TestCollectionViewCell")
        title = "Detail List"
    }
}
