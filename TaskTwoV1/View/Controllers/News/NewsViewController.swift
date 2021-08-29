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
    private var sideMenuShadowView: UIView!
    private var sideMenuRevealWidth: CGFloat = 260
    private var isExpanded: Bool = false
    private var revealSideMenuOnTop: Bool = true

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
        listButton.layer.cornerRadius = 5
        gridButton.layer.cornerRadius = 5
        setupCollectionView()
        flowLayoutForManagedGridAndList()
        setupRefreshControl()
        setupNewsModel()
        setupSideMenu()
        setupDarkModeColor()
       // catsUIViewController.view.frame = view.bounds
    }
    // MARK: - Actions

    @IBAction func didTapMenuButton() {
        present(sideMenu!, animated: true)
    }
    
    @IBAction func onClickSwitch(_ sender: UISwitch) {
        if #available(iOS 13.0, *) {
            let appDelegate = UIApplication.shared.windows.first
            if sender.isOn {
                appDelegate?.overrideUserInterfaceStyle = .dark
                return
            }
            appDelegate?.overrideUserInterfaceStyle = .light
            return
        }
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

    func setupNewsModel() {
        newsModel = NewsDataModel(delegate: self)
        newsModel.fetchNewsData(searchQuery: "")
        if newsModel.filterOptions.isEmpty {
            filterButton.isEnabled = true
        }
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

    func didselectMenuItem(named: String) {
        sideMenu?.dismiss(animated: true, completion: { [weak self] in

            if named == "News" {
              self?.showViewController(viewController: UINavigationController.self, storyboardId: "NewsNavID")
            } else if named == "StarWars" {

            self?.showViewController(viewController: UINavigationController.self, storyboardId: "StarNavID")
            } else if named == "AllBreeds" {

             self?.showViewController(viewController: UINavigationController.self, storyboardId: "AllBreedNavID")
            } else if named == "Cats" {
               self?.showViewController(viewController: UINavigationController.self, storyboardId: "CatsNavID")
            }
           })
    }

    func showViewController<T: UIViewController>(viewController: T.Type, storyboardId: String) {
        for subview in view.subviews where subview.tag == 99 {
                subview.removeFromSuperview()
        }

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewC = storyboard.instantiateViewController(withIdentifier: storyboardId) as? T else { return }
        viewC.view.tag = 99
        view.insertSubview(viewC.view, at: self.revealSideMenuOnTop ? 0 : 1)
        addChild(viewC)
        if !self.revealSideMenuOnTop {
            if isExpanded {
                viewC.view.frame.origin.x = self.sideMenuRevealWidth
            }
            if self.sideMenuShadowView != nil {
                viewC.view.addSubview(self.sideMenuShadowView)
            }
        }
        viewC.didMove(toParent: self)
    }
    
    func setupDarkModeColor() {
        listButton.backgroundColor = UIColor.setColor(lightColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), darkColor: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1))
        gridButton.backgroundColor = UIColor.setColor(lightColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), darkColor: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1))
        navigationController?.navigationBar.barTintColor = UIColor.setColor(lightColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), darkColor: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1))
        tabBarController?.tabBar.tintColor = UIColor.setColor(lightColor: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), darkColor: #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1))
        tabBarController?.tabBar.barTintColor = UIColor.setColor(lightColor: #colorLiteral(red: 0.2104677122, green: 0.2125515509, blue: 0.2125515509, alpha: 1), darkColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    }
}

extension UIColor {
    
   static func setColor(lightColor: UIColor, darkColor: UIColor) -> UIColor {
        if #available(iOS 13, *) {
            return UIColor{ (traitCollection) -> UIColor in
                return traitCollection.userInterfaceStyle == .light ? lightColor : darkColor
            }
        } else {
            return lightColor
        }
    }
    
}
