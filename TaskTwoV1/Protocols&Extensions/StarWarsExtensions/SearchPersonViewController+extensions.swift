//
//  SearchPersonViewController+extensions.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 18.07.2021.
//

import UIKit

extension SearchPersonViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = secondTableView.dequeueReusableCell(
                withIdentifier: "PersonTableViewCell", for: indexPath) as? PersonTableViewCell else {
            fatalError()
        }
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        secondTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}

extension SearchPersonViewController:  UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }

        print(text)
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
                    self?.searchVC.dismiss(animated: true, completion: nil)
                }
            case.failure(let error):
            print(error)
            }
        }
    }
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        
        print(text)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        secondTableView.reloadData()
    }
}
