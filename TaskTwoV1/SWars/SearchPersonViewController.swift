//
//  SearchPersonViewController.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 01.07.2021.
//

import UIKit

class SearchPersonViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var secondTableView: UITableView!
    
    let searchVC = UISearchController(searchResultsController: nil)
    var results = [Results]()
    var viewModels = [CellTableViewModel]()
    
    // MARK: - Life cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        secondTableView.delegate = self
        secondTableView.dataSource = self
        setupColorTabbar()
        createSearchBar()
    }
    
    func createSearchBar() {
        navigationItem.searchController = searchVC
        searchVC.searchBar.delegate = self
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
        guard let contoller = segue.destination as? DetailPageViewController,
              let indexPath = secondTableView.indexPathForSelectedRow
        else { return }
        let item = results[indexPath.row]
        contoller.namePerson = item.name
        contoller.genderTipe = item.gender
    }
}
