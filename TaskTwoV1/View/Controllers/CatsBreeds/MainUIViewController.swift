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
    var viewModels = [CellViewModel]()

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
        getAllBreed()
        fileManagerWork()
   }

    func getAllBreed() {
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
