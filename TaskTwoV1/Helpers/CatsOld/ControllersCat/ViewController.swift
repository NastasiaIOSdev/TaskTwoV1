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
        self.tabBarController?.tabBar.tintColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1)
        self.tabBarController?.tabBar.barTintColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1)
        
        tableView.register(FullWidthTableViewCell.nib(), forCellReuseIdentifier: FullWidthTableViewCell.identifier)
        tableView.register(HalfWidthTableViewCell.nib(), forCellReuseIdentifier: HalfWidthTableViewCell.identifier)
        tableView.register(TableViwInTableViewCell.nib(), forCellReuseIdentifier: TableViwInTableViewCell.identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        title = "Cats"
        
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
        if indexPath.row % 3 == 0 {
              if let cell = tableView.dequeueReusableCell(withIdentifier: "FullWidthTableViewCell") as? FullWidthTableViewCell {
                cell.configure(with: viewModels[indexPath.row])
//                cell.contentView.layer.masksToBounds = false
//                cell.contentView.layer.shadowColor = UIColor.lightGray.cgColor
//                cell.contentView.backgroundColor = UIColor.white
//                cell.contentView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
//                cell.contentView.layer.shadowOpacity = 0.5
                  return cell
              }
        } else if (indexPath.row - 1) % 3 == 0 || indexPath.row == 1 {
              if let cell2 = tableView.dequeueReusableCell(withIdentifier: "HalfWidthTableViewCell") as? HalfWidthTableViewCell {
                  cell2.configure(with: viewModels[indexPath.row])
                  return cell2
              }
        } else if (indexPath.row - 1) % 2 == 0 || (indexPath.row - 1) % 2 == 1 || indexPath.row == 2 {
            if let cell3 = tableView.dequeueReusableCell(withIdentifier: "TableViwInTableViewCell") as? TableViwInTableViewCell {
                return cell3
            }
        }
        
          return UITableViewCell()
      }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
