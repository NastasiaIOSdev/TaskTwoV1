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
    @IBOutlet weak var searchBar: UISearchBar!
    
    var results = [Results]()
    var viewModels = [CellTableViewModel]()
    
    // MARK: - Life cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        secondTableView.delegate = self
        secondTableView.dataSource = self
        searchBar.delegate = self
        fetchPeopleList()
        setupColorTabbar()
    }
    
    func setupColorTabbar() {
        self.tabBarController?.tabBar.tintColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1)
        self.tabBarController?.tabBar.barTintColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navBarSetup()
    }
    
    func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    func navBarSetup() {
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.barStyle = UIBarStyle.black
        navigationBar?.tintColor = UIColor.white
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "navBarImage")
        imageView.image = image
        navigationItem.titleView = imageView
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    private func fetchPeopleList() {
        APIService.shared.getPeopleList { [weak self] result in
            switch result {
            case.success(let results):
                self?.results = results
                self?.viewModels = results.compactMap({
                    CellTableViewModel(
                        title: $0.name,
                        subtitle: $0.gender)
                })
                DispatchQueue.main.async {
                    self?.secondTableView.reloadData()
                }
                
            case.failure(let error):
                print(error)
            }
        }
        
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
