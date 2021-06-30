//
//  SearchPersonViewController.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 01.07.2021.
//

import UIKit

class SearchPersonViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    
    // MARK: - IBOutlets
    
    @IBOutlet var secondTableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    private var searchVC = UISearchController(searchResultsController: nil)
    private var results = [Results]()
    private var viewModels = [CellTableViewModel]()
    
    // MARK: - Life cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        secondTableView.delegate = self
        secondTableView.dataSource = self
        
        fetchPeopleList()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    private func fetchPeopleList() {
        APIService.shared.getPeopleList{ [weak self] result in
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
    
    // MARK: - Table
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = secondTableView.dequeueReusableCell(withIdentifier: "PersonTableViewCell", for: indexPath) as? PersonTableViewCell else {
            fatalError()
        }
        cell.configure(with:
            viewModels[indexPath.row])
        return cell
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        secondTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let contoller = segue.destination as? DetailPageViewController,
              let indexPath = secondTableView.indexPathForSelectedRow
        else { return }
        let item = results[indexPath.row]
        contoller.namePerson = item.name
        contoller.genderTipe = item.gender
    }
    
    //MARK: - Search
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        APIService.shared.searchPeopleList(with: text) { [weak self] result in
            switch result {
            case.success(let results):
                self?.results = results
                self?.viewModels = results.compactMap({
                    CellTableViewModel(
                        title: $0.name ,
                        subtitle: $0.gender )
                })
                
                DispatchQueue.main.async {
                    self?.secondTableView.reloadData()
                }
            case.failure(let error):
            print(error)
            }
        }
    }
}
