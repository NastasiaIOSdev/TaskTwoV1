//
//  SearchPersonViewController.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 01.07.2021.
//

import UIKit

class SearchPersonViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet weak var collectionView: UICollectionView!
    let cellIdentifier = "ItemCollectionViewCell"
    var results = [Results]()
    var viewModels = [CellTableViewModel]()
    let countCells = 2
    let offset: CGFloat = 10.0
    let segueIdentifier = "Detail"

    // MARK: - Life cycles

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setUpNavigationBar()
        setupColorTabbar()
   }
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: "ItemCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
    }
    func setUpNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = false
        title = "Star Wars"
        searchController.searchBar.placeholder = "Search persone..."
        searchController.searchBar.tintColor = UIColor.black
    }
    func setupColorTabbar() {
        self.tabBarController?.tabBar.tintColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1)
        self.tabBarController?.tabBar.barTintColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1)
    }

    override func viewDidAppear(_ animated: Bool) {
    }

    func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let item = sender as? CellTableViewModel else { return }
        if segue.identifier == segueIdentifier {
            if let viewC = segue.destination as? DetailPageViewController {
                viewC.namePerson = item.title
                viewC.genderTipe = item.subtitle
            }
        }
    }
  // MARK: - Animation
  func collectionView(_ collectionView: UICollectionView,
                      willDisplay cell: UICollectionViewCell,
                      forItemAt indexPath: IndexPath) {
        cell.alpha = 0
        let transform = CATransform3DTranslate(CATransform3DIdentity, -250, 20, 0)
        cell.layer.transform = transform
        UIView.animate(withDuration: 1.2) {
            cell.alpha = 1
            cell.layer.transform = CATransform3DIdentity
        }
    }
}
