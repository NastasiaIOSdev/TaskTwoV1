//
//  ViewController.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 28.06.2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    private var viewModels = [FullWidthViewCellViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FullWidthTableViewCell.nib(), forCellReuseIdentifier: FullWidthTableViewCell.identifier)
        tableView.register(HalfWidthTableViewCell.nib(), forCellReuseIdentifier: HalfWidthTableViewCell.identifier)
        tableView.register(TableViwInTableViewCell.nib(), forCellReuseIdentifier: TableViwInTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        title = "Cats List"
        
        APICaller.shared.getBreed { [weak self] result in
            switch result {
            case.success(let breed):
                self?.viewModels = breed.compactMap({
//                    BigTableViewCellViewModel(
//                        title: $0.name,
//                        subtitle: $0.origin ?? "No country",
//                        imageUrl: URL(string: $0.image?.url ?? "")
//                    )
                })
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                
            case.failure(let error):
                print(error)
            }
        }
    }
    // MARK: - UITavleView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 17
        // return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        
//        if indexPath.row % 3 == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: FullWidthTableViewCell.identifier, for: indexPath)
//        }
//        else if (indexPath.row - 1) % 3 == 0 || indexPath.row == 1{
//            cell = tableView.dequeueReusableCell(withIdentifier: HalfWidthTableViewCell.identifier, for: indexPath)
//        } else {
//            cell = tableView.dequeueReusableCell(withIdentifier: TableViwInTableViewCell.identifier, for: indexPath)
//        }
        cell.configure(with: viewModels[indexPath.row])
        return cell!
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
