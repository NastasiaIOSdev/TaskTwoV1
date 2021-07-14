//
//  MainViewController.swift
//  TaskTwoV1
//
//  Created by Анастасия Ларина on 03.07.2021.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - IBOUtlets

    @IBOutlet weak var tableViewSecond: UITableView!
    private var breed = [Breed]()
    private var viewModels = [CellViewModel]()

    // MARK: - Life cycles

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.tintColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1)
        self.tabBarController?.tabBar.barTintColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1)
        tableViewSecond.register(FirstTableViewCell.nib(), forCellReuseIdentifier: FirstTableViewCell.identifier)
        tableViewSecond.register(LastTableViewCell.nib(), forCellReuseIdentifier: LastTableViewCell.identifier)
        tableViewSecond.register(SecondTableViewCell.nib(), forCellReuseIdentifier: SecondTableViewCell.identifier)
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
                        aboutBreed: $0.origin,
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
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let contoller = segue.destination as? CatsCollectionViewController,
              let indexPath = tableViewSecond.indexPathForSelectedRow
        else { return }
        let item = viewModels[indexPath.row]
        contoller.nameBreed = item.title
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
            if let cell2 = tableView.dequeueReusableCell(
                withIdentifier: "SecondTableViewCell") as? SecondTableViewCell {
                cell2.configure(with: viewModels[indexPath.row])
                return cell2
            }
        } else if (indexPath.row - 1) % 2 == 0 || (indexPath.row - 1) % 2 == 1 || indexPath.row == 2 {
            if let cell3 = tableView.dequeueReusableCell(
                withIdentifier: "LastTableViewCell") as? LastTableViewCell {
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
