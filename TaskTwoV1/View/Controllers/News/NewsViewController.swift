//
//  NewsViewController.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 18.08.2021.
//

import UIKit
import Foundation

class NewsViewController: UIViewController {

   // MARK: - IBOutlets

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var listButton: UIButton!
    @IBOutlet weak var gridButton: UIButton!

    // MARK: - Properties

    let cellIdentifier = "GridCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News"
        listButton.layer.cornerRadius = 5
        gridButton.layer.cornerRadius = 5

    }

}
