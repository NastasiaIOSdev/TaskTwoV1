//
//  DodgCollectionViewController.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 09.07.2021.
//

import UIKit

class CatsCollectionViewController: UIViewController {
    var selectedCell: CollectionViewCell?
    private var viewModels = [CellViewModel]()
    @IBOutlet private var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
       }
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
}
}
