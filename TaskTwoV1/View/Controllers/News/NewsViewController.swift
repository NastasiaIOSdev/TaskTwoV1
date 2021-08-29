//
//  NewsViewController.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 18.08.2021.
//

import UIKit
import Foundation
import SideMenu

class NewsViewController: UIViewController, MenuControllerDelegate, UINavigationControllerDelegate {

    // MARK: - IBOutlets

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var newsSearchBar: UISearchBar!
    @IBOutlet weak var filterButton: UIBarButtonItem!

    @IBOutlet weak var listButton: UIButton!
    @IBOutlet weak var gridButton: UIButton!

    // MARK: - Properties
    private var sideMenu: SideMenuNavigationController?
    private let catsUIViewController = FirstViewController()
    private let starWarsViewController = SecondViewController()
    private let allBreedsViewController = ThirdViewController()
    var refreshControl: UIRefreshControl!
    var networkingManager: APIService = APIService()
    var newsModel: NewsDataModel!
    var newsUrl: String = ""

    let cellIdentifier = "GridCell"
    let segueIdentifier = "Detail"
    let segueIdentifier2 = "toFilter"

    var articles = [Article]()
    var listType: CGFloat = 1
    var searchVC = UISearchController(searchResultsController: nil)

    // MARK: - LifeCycles

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.prefetchDataSource = self
        newsSearchBar.delegate = self
        title = "News"
        listButton.layer.cornerRadius = 5
        gridButton.layer.cornerRadius = 5
        setupCollectionView()
        flowLayoutForManagedGridAndList()
        setupRefreshControl()
        setupNewsModel()
        setupSideMenu()
        addChildControllers()
    }
    
    func setupNewsModel() {
        newsModel = NewsDataModel(delegate: self)
        newsModel.fetchNewsData(searchQuery: "")
        if newsModel.filterOptions.isEmpty {
            filterButton.isEnabled = true
        }
    }
    
    // MARK: - Actions

    @IBAction func didTapMenuButton() {
        present(sideMenu!, animated: true)
    }

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
    
    @objc func refresh(sender: AnyObject) {
        newsModel.fetchedArticles.removeAll()
        newsModel.currentPage = 0
        self.collectionView.reloadData()
        self.refreshControl?.endRefreshing()
    }
    
    func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Loading...")
        refreshControl.addTarget(self, action: #selector(self.refresh(sender:)), for: UIControl.Event.valueChanged)
        collectionView.addSubview(refreshControl)
    }
    
    func setupSideMenu() {
        let menu = MenuController(with: ["Cats",
                                         "StarWars",
                                         "AllBreeds",
                                         "News"])
        menu.delegate = self
        sideMenu = SideMenuNavigationController(rootViewController: menu)
        sideMenu?.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
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
        self.collectionView.reloadData()
    }

    func createSearchBar() {
        navigationItem.searchController = searchVC
        searchVC.searchBar.delegate = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    // MARK: - Prepare for segue

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier2 {
            guard let filterVC = segue.destination as? FilterViewController else { return }
            filterVC.allFilters = newsModel.filterOptions
            filterVC.chosenFilters = newsModel.chosenFilters
            filterVC.delegate = self
        } else if segue.identifier == segueIdentifier,
                  let viewC = segue.destination as? DetailViewController,
                  let item = sender as? Article {
            viewC.nameArticle = item.title
            viewC.descriptionArticle = item.description
            viewC.author = item.author
            if let urlString = item.urlToImage {
                viewC.imageURL = URL(string: urlString)
            }
        }
    }
    
    private func addChildControllers() {
        addChild(catsUIViewController)
        addChild(starWarsViewController)
        addChild(allBreedsViewController)

        view.addSubview(catsUIViewController.view)
        view.addSubview(starWarsViewController.view)
        view.addSubview(allBreedsViewController.view)

        catsUIViewController.view.frame = view.bounds
        starWarsViewController.view.frame = view.bounds
        allBreedsViewController.view.frame = view.bounds

        catsUIViewController.didMove(toParent: self)
        starWarsViewController.didMove(toParent: self)
        allBreedsViewController.didMove(toParent: self)

        catsUIViewController.view.isHidden = true
        starWarsViewController.view.isHidden = true
        allBreedsViewController.view.isHidden = true
    }

    func didselectMenuItem(named: String) {
        sideMenu?.dismiss(animated: true, completion: { [weak self] in
            self?.title = named
            
            if named == "News" {
                self?.catsUIViewController.view.isHidden = true
                self?.starWarsViewController.view.isHidden = true
                self?.allBreedsViewController.view.isHidden = true
//                self?.showViewController(viewController: UINavigationController.self, storyboardId: "NewsNavID")
            } else if named == "StarWars" {
                self?.catsUIViewController.view.isHidden = true
                self?.starWarsViewController.view.isHidden = false
                self?.allBreedsViewController.view.isHidden = true
//             self?.showViewController(viewController: UINavigationController.self, storyboardId: "StarNavID")
            } else if named == "AllBreeds" {
                self?.catsUIViewController.view.isHidden = true
                self?.starWarsViewController.view.isHidden = true
                self?.allBreedsViewController.view.isHidden = false
 //               self?.showViewController(viewController: UINavigationController.self, storyboardId: "AllBreedNavID")
            } else if named == "Cats" {
                self?.catsUIViewController.view.isHidden = false
                self?.starWarsViewController.view.isHidden = true
                self?.allBreedsViewController.view.isHidden = true
               //self?.showViewController(viewController: UINavigationController.self, storyboardId: "CatsNavID")
            }
           })
    }

//    private var sideMenuShadowView: UIView!
//    private var sideMenuRevealWidth: CGFloat = 260
//    private var isExpanded: Bool = false
//    private var revealSideMenuOnTop: Bool = true
//
//    func showViewController<T: UIViewController>(viewController: T.Type, storyboardId: String) -> () {
//        // Remove the previous View
//        for subview in view.subviews where subview.tag == 99 {
//                subview.removeFromSuperview()
//        }
//
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        guard let viewC = storyboard.instantiateViewController(withIdentifier: storyboardId) as? T else { return }
//        viewC.view.tag = 99
//        view.insertSubview(viewC.view, at: self.revealSideMenuOnTop ? 0 : 1)
//        addChild(viewC)
//        if !self.revealSideMenuOnTop {
//            if isExpanded {
//                viewC.view.frame.origin.x = self.sideMenuRevealWidth
//            }
//            if self.sideMenuShadowView != nil {
//                viewC.view.addSubview(self.sideMenuShadowView)
//            }
//        }
//        viewC.didMove(toParent: self)
//    }
}
