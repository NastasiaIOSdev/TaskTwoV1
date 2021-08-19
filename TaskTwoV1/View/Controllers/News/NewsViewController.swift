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
    let segueIdentifier = "Detail"
    var viewModels = [NewsViewModel]()
    var articles = [Article]()
    var listType: CGFloat = 1

    // MARK: - LifeCycles

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News"
        listButton.layer.cornerRadius = 5
        gridButton.layer.cornerRadius = 5
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView.reloadData()
        fetchTopStories()
        setupCollectionView()
        flowLayoutForManagedGridAndList()

    }

    // MARK: - Actions

    @IBAction func gridListButtonTap(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            self.listType = 1
            print("Default Button Called 1")
        case 2:
            self.listType = 2
            print("Default Button Called 2")
        default:
            print("Default Button Called ")
        }
        self.collectionView.reloadData()
    }

    func flowLayoutForManagedGridAndList() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        layout.minimumLineSpacing = 5.0
        layout.minimumInteritemSpacing = 5.0
        self.collectionView.setCollectionViewLayout(layout, animated: true)
        self.collectionView.reloadData()
    }

    func fetchTopStories() {
        APIService.shared.getTopStories { [weak self] result in
            switch result {
            case.success(let articles):
                self?.articles = articles
                self?.viewModels = articles.compactMap({ NewsViewModel(
                    title: $0.title,
                    subtitle: $0.description ?? "No Description",
                    authorArticle: $0.author ?? "No Author",
                    imageUrl: URL(string: $0.urlToImage ?? "")
                    )
                })
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            case.failure(let error):
                print(error)
            }
        }
    }

    func configureCell(cell: GridCell, forIndexPath indexPath: IndexPath) {
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 5

        cell.newsImage.layer.borderColor = UIColor.lightGray.cgColor
        cell.newsImage.layer.borderWidth = 1
        cell.newsImage.layer.cornerRadius = 5
    }

    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        let listCellNib = UINib(nibName: GridCell.reuseIdentifierListCell, bundle: nil)
        self.collectionView.register(listCellNib, forCellWithReuseIdentifier: GridCell.reuseIdentifierListCell)

        let gridCellNib = UINib(nibName: GridCell.reuseIdentifierGridCell, bundle: nil)
        self.collectionView.register(gridCellNib, forCellWithReuseIdentifier: GridCell.reuseIdentifierGridCell)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let item = sender as? NewsViewModel else { return }
        if segue.identifier == segueIdentifier {
            if let viewC = segue.destination as? DetailViewController {
                viewC.nameArticle = item.title
                viewC.descriptionArticle = item.subtitle
                viewC.author = item.authorArticle
                viewC.imageURL = item.imageUrl
            }
        }
    }

}
