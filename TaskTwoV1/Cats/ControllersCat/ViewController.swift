//
//  ViewController.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 28.06.2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - IBOUtlets
    
    @IBOutlet var tableView: UITableView!
    
    private var viewModels = [CellViewModel]()
    
    // MARK: - Life cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(FullWidthTableViewCell.nib(), forCellReuseIdentifier: FullWidthTableViewCell.identifier)
        tableView.register(HalfWidthTableViewCell.nib(), forCellReuseIdentifier: HalfWidthTableViewCell.identifier)
        tableView.register(TableViwInTableViewCell.nib(), forCellReuseIdentifier: TableViwInTableViewCell.identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        title = "Cats List"
        
        APIService.shared.getBreed { [weak self] result in
            switch result {
            case.success(let breed):
                self?.viewModels = breed.compactMap({
                    CellViewModel(
                        title: $0.name,
                        subtitle: $0.origin,
                        imageUrl: URL(string: $0.image?.url ?? "")
                    )
                })
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                
            case.failure(let error):
                print(error)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    // MARK: - UITavleView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: HalfWidthTableViewCell.identifier, for: indexPath) as? HalfWidthTableViewCell else {
            fatalError()
        }
        cell.configure(with: viewModels[indexPath.row])
        return cell
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
