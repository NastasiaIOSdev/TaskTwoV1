//
//  MainUIViewController.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 11.07.2021.
//

import UIKit

class MainUIViewController: UIViewController {
    // MARK: - IBOUtlets

    @IBOutlet weak var tableViewSecond: UITableView!
    private var breed = [Breed]()
    private var viewModels = [CellViewModel]()

    // MARK: - Life cycles

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.tintColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1)
        self.tabBarController?.tabBar.barTintColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1)
        tableViewSecond.register(FirstUITableViewCell.nib(), forCellReuseIdentifier: FirstUITableViewCell.identifier)
        tableViewSecond.register(SecondUITableViewCell.nib(), forCellReuseIdentifier: SecondUITableViewCell.identifier)
        tableViewSecond.register(LastUITableViewCell.nib(), forCellReuseIdentifier: LastUITableViewCell.identifier)
        tableViewSecond.delegate = self
        tableViewSecond.dataSource = self
        title = "Cats"

        APIService.shared.getBreed { [weak self] result in
            switch result {
            case.success(let breed):
                self?.viewModels = breed.compactMap({
                    CellViewModel(
                        title: $0.name,
                        subtitle: $0.origin,
                        aboutBreed: $0.description,
                        imageUrl: URL(string: $0.image?.url ?? "")
                    )
                })
                
                for element in breed {
                  //  self?.viewModels.imagesArray.append(element.image)
                }
                
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

extension MainUIViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 
  
        if indexPath.row % 3 == 0 {
            if let cell = tableView.dequeueReusableCell(
                withIdentifier: "FirstUITableViewCell") as? FirstUITableViewCell {
                let vc = DetailViewController()
                cell.imageDelegate = vc

                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true, completion: nil)
                cell.passImage()
            }
        } else if (indexPath.row - 1) % 3 == 0 || indexPath.row == 1 {
            if let cell2 = tableView.dequeueReusableCell(
                withIdentifier: "SecondUITableViewCell") as? SecondUITableViewCell {
         
            }
        } else if (indexPath.row - 1) % 2 == 0 || (indexPath.row - 1) % 2 == 1 || indexPath.row == 2 {
            if let cell3 = tableView.dequeueReusableCell(
                withIdentifier: "LastUITableViewCell") as? LastUITableViewCell {
//                let vc = DetailTableViewController()
//                self.present(vc, animated: true, completion: nil)
//                cell3.collectionViewSecond.dataSource = cell3
//                cell3.collectionViewSecond.delegate = cell3
               
            }
        }
        
    }
}

extension MainUIViewController: UITableViewDataSource {

    // MARK: - UITavleView

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 3 == 0 {
            if let cell = tableView.dequeueReusableCell(
                withIdentifier: "FirstUITableViewCell") as? FirstUITableViewCell {
                cell.configure(with: viewModels[indexPath.row])
                
                return cell
            }
        } else if (indexPath.row - 1) % 3 == 0 || indexPath.row == 1 {
            if let cell2 = tableView.dequeueReusableCell(
                withIdentifier: "SecondUITableViewCell") as? SecondUITableViewCell {
                cell2.configure(with: viewModels[indexPath.row])
                return cell2
            }
        } else if (indexPath.row - 1) % 2 == 0 || (indexPath.row - 1) % 2 == 1 || indexPath.row == 2 {
            if let cell3 = tableView.dequeueReusableCell(
                withIdentifier: "LastUITableViewCell") as? LastUITableViewCell {
                cell3.configure(with: viewModels)
                return cell3
            }
        }

        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        180.0
    }
}
