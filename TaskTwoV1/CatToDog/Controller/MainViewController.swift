//
//  MainViewController.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 03.07.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - IBOUtlets
    
    @IBOutlet var tableViewSecond: UITableView!
    
    private var viewModels = [CellViewModel]()
    
    // MARK: - Life cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewSecond.register(FirstTableViewCell.nib(), forCellReuseIdentifier: FirstTableViewCell.identifier)
        tableViewSecond.register(SecondTableViewCell.nib(), forCellReuseIdentifier: SecondTableViewCell.identifier)
//        tableViewSecond.register(FTableViewCell.nib(), forCellReuseIdentifier: FTableViewCell.identifier)
        
        tableViewSecond.delegate = self
        tableViewSecond.dataSource = self
        title = "Another List"
        
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
                    self?.tableViewSecond.reloadData()
                }
                
            case.failure(let error):
                print(error)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

}


extension MainViewController: UITableViewDelegate {
    
}

extension MainViewController: UITableViewDataSource {
    
    // MARK: - UITavleView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 3 == 0 {
              if let cell = tableView.dequeueReusableCell(withIdentifier: "FirstTableViewCell") as? FirstTableViewCell {
                cell.configure(with: viewModels)
               return cell
              }
        } else if (indexPath.row - 1) % 3 == 0 || indexPath.row == 1 {
              if let cell2 = tableView.dequeueReusableCell(withIdentifier: "SecondTableViewCell") as? SecondTableViewCell {
                  cell2.configure(with: viewModels[indexPath.row])
                  return cell2
              }
        } else if (indexPath.row - 1) % 2 == 0 || (indexPath.row - 1) % 2 == 1 || indexPath.row == 2 {
            if let cell3 = tableView.dequeueReusableCell(withIdentifier: "FTableViewCell") as? FTableViewCell {
                cell3.configure(with: viewModels[indexPath.row])
                return cell3
            }
        }
        
          return UITableViewCell()
      }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        160.0
    }
}
